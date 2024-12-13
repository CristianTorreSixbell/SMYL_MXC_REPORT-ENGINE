import jwt from 'jsonwebtoken';
import logger from '../lib/Logger.js';
import crypto from 'crypto';
import TokenModel from '../models/tokenModel.js';
import { ApplicationModel } from '../models/clientApplicationModel.js';
import { chargeData } from '../lib/dotenvExtractor.js';

chargeData();

class VerifyToken {
    constructor() {
        this.logEvent = (type, event, submoduleInd) => {
            const submodules = ['MAIN', 'VERIFY-CLIENT', 'VERIFY-TOKEN-IN-OAUTH'];
            const moduleName = 'VERIFY-TOKEN';
            const submodule = parseInt(submoduleInd) ? `][${submodules[parseInt(submoduleInd)]}` : '';
            
            if (type.toLowerCase().includes('error')) {
                logger.error(`[${moduleName}${submodule}(${type})]: ${event}`);
                return;
            }
            if (type.toLowerCase().includes('info')) {
                logger.info(`[${moduleName}${submodule}(${type})]: ${event}`);
                return;
            }
            if (type.toLowerCase().includes('warn')) {
                logger.warn(`[${moduleName}${submodule}(${type})]: ${event}`);
                return;
            } else {
                logger.warn(`[${moduleName}${submodule}(${type})]: ${event}\n(Error en tipificación de log)`);
                return;
            }
        };
        
        this.secretKey = process.argv[9] || null;
        this.encryptionKey = process.argv[6] || null;
        this.verifyToken = this.verifyToken.bind(this);
        this.verifyClient = this.verifyClient.bind(this);
        this.verifyTokenInOauth = this.verifyTokenInOauth.bind(this);
        this.decryptToken = (encryptedToken) => {
            const textParts = encryptedToken.split(':');
            const iv = Buffer.from(textParts.shift(), 'hex');
            const encryptedText = textParts.join(':');
            const decipher = crypto.createDecipheriv('aes-256-cbc', Buffer.from(this.encryptionKey, 'utf8'), iv);
            let decrypted = decipher.update(encryptedText, 'hex', 'utf8');
            decrypted += decipher.final('utf8');
            this.logEvent('INFO', 'Token decrypted successfully', 1);
            return decrypted;
        };
        
    }

    async verifyToken(req, res) {
        try {
            this.logEvent('INFO', 'Verifying token...', 0);

            const token = req.headers['authorization'].split('Bearer ')[1].trim();

            this.logEvent('INFO', `Token recibido correctamente\nEvaluando...`, 0);

            const decoded = jwt.verify(token, this.secretKey);
            const clientSecret = decoded.clientSecret;
            const clientId = decoded.clientId;
            const scope = decoded.scope;
 
            const verifyResult = await this.verifyClient(clientId, clientSecret);
            const tokenVerifyResult = await this.verifyTokenInOauth(clientId, token);
            if (verifyResult.status !== 200 || tokenVerifyResult.status !== 200) {
                throw new Error('Error verifying client or token');
            }
            
            const combinedResponse = {
                message: 'Token verified successfully',
                decoded: decoded,
                configResult: verifyResult.data
            };
            const encodedResponse = jwt.sign(combinedResponse, this.secretKey, { expiresIn: '1h' });
            return res.status(200).json({ encodedResponse });
        } catch (e) {
            this.logEvent('ERROR', `Error verifying token: ${e}`, 0);
            console.log(e);
            console.log(JSON.stringify(e));
            return res.status(401).json({ message: 'Invalid token' });
        }
    }

    async verifyClient(clientId, clientSecret) {
        try {
            if (!clientId || !clientSecret) {
                throw new Error('Invalid parameters');
            }
            this.logEvent('INFO', 'Verifying client...', 1);

            const findResult = await ApplicationModel.find({});
            if (!findResult || findResult.length === 0) {
                throw new Error('There are no clients in the database');
            }
            
            let isIN = false;
            for (const result of findResult) {
                if (result.clientId === clientId && clientSecret === result.clientSecret) {
                    isIN = true;
                }
            }
            if (!isIN) {
                throw new Error('Client not found');
            }

            this.logEvent('INFO', 'Client verified successfully', 1);

            return {
                status: 200,
                data: `Client verified successfully,` + isIN
            };

        } catch (e) {
            this.logEvent('ERROR', `Error verifying client: ${e}`, 1);
            console.log(e);
            console.log(JSON.stringify(e));
            return {
                status: 500,
                data: `[verifyClient(Error)]: (" Error verifying client ${e} ")`
            };
        }
    }

    async verifyTokenInOauth(clientId, token) {
        try {
            if (!clientId || !token) {
                throw new Error('Invalid parameters');
            }
            this.logEvent('INFO', 'Verifying token in oauth...', 2);

            const findResult = await TokenModel.find({});
            if (!findResult || findResult.length === 0) {
                throw new Error('There is no token in the database');
            }
            let isIN = false;
            for (const result of findResult) {
                console.log( result.token );
                const decryptedToken =  result.token ;
                const decryptedClientName =  result.client_name ;
                if (decryptedClientName === clientId && decryptedToken.includes(token)) {
                    isIN = true;
                }
            }
            if (!isIN) {
                throw new Error('Token not found');
            }
            this.logEvent('INFO', 'Token verified successfully', 2);

            return {
                status: 200,
                data: `Token verified successfully,` + isIN
            };
        } catch (e) {
            this.logEvent('ERROR', `Error verifying token in oauth: ${e}`, 0);
            console.log(e);
            console.log(JSON.stringify(e));
            return {
                status: 500,
                data: `[verifyTokenInOauth(Error)]: (" Error verifying token in oauth ${e} ")`
            };
        }
    }
}

export default VerifyToken;