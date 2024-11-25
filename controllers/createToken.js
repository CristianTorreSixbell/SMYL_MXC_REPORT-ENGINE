import { connectTo, disconectMongo } from '../utils/mongoDb.js';
import jwt from 'jsonwebtoken';
import { SECRET_KEY, TOKEN_EXPIRATION, ENCRYPTION_KEY } from '../utils/dotenv.js';
import logger from '../utils/Logger.js';
import { TokenModel } from '../models/tokens.js';
import { ApplicationModel } from '../models/applications.js';
import crypto from 'crypto';

class GenerateToken {
    constructor() {
        this.logEvent = (type, event, submoduleInd) => {
            const submodules = ['ENCRYPT-TOKEN', 'DECRYPT-TOKEN', 'GENERATE-TOKEN', 'VERIFY-CLIENT'];
            const moduleName = 'GENERATE-TOKEN';
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

        this.tokenGenerationName = (event) => `[generateToken(${event})]`;
        this.verifyClientName = (event) => `[verifyClient(${event})]:`;
        this.expiration = parseInt(TOKEN_EXPIRATION, 10);
        this.secretKey = SECRET_KEY;
        this.encryptionKey = ENCRYPTION_KEY;
        this.generateToken = this.generateToken.bind(this);
        this.verifyClient = this.verifyClient.bind(this);
        this.tokenDataBase = 'Insight_Oauth';
        this.configDataBase = 'Insight_Config';
    }

    encryptToken(token) {
        const cipher = crypto.createCipher('aes-256-cbc', this.encryptionKey);
        let encrypted = cipher.update(token, 'utf8', 'hex');
        encrypted += cipher.final('hex');
        this.logEvent('INFO', 'Token encrypted successfully', 0);
        return encrypted;
    }

    decryptToken(encryptedToken) {
        const decipher = crypto.createDecipher('aes-256-cbc', this.encryptionKey);
        let decrypted = decipher.update(encryptedToken, 'hex', 'utf8');
        decrypted += decipher.final('utf8');
        this.logEvent('INFO', 'Token decrypted successfully', 1);
        return decrypted;
    }

    async generateToken(req, res) {
        try {
            if (!this.secretKey) {
                throw new Error('Error: Invalid Secret Key');
            }
            this.logEvent('INFO', 'Generating token...', 2);
            const authHeader = req.headers['authorization'];
            const encodedData = authHeader && authHeader.split(' ')[1];
            if (!encodedData) {
                logger.error(`${this.tokenGenerationName('ERROR')} Invalid Token body`);
                return res.status(400).json({ message: `${this.tokenGenerationName('ERROR')} Invalid body` });
            }

            const decodedString = Buffer.from(encodedData, 'base64').toString('ascii');
            const [clientId, clientSecret, clientScope] = decodedString.split(':');
            if (!clientId || !clientSecret || !clientScope) {
                logger.error(`${this.tokenGenerationName('ERROR')} Missing parameters`);
                return res.status(400).json({ error: 'Invalid Parameters' });
            }

            const contentType = req.headers['content-type'];
            if (contentType !== 'application/x-www-form-urlencoded' || req.body.grant_type !== 'client_credentials') {
                return res.status(400).json({ error: 'Unsupported grant type or invalid content type' });
            }

            await connectTo(this.tokenDataBase);
            const introspectionResult = await this.verifyClient(clientId, clientSecret);
            if (!introspectionResult) {
                throw new Error('Error: Invalid Client');
            }
            const payload = { clientId, scope: clientScope, clientSecret: clientSecret };
            const options = { expiresIn: this.expiration, algorithm: 'HS256' };
            const token = jwt.sign(payload, this.secretKey, options);

            const encryptedToken = this.encryptToken(token);

            const findResult = await TokenModel.findOne({ token: 'Bearer ' + encryptedToken });
            const tokenToSave = {
                "token": 'Bearer ' + encryptedToken,
                "expiration_date": new Date(Date.now() + this.expiration * 1000),
                "applicationId": clientId
            };

            if (!findResult) {
                const saveObj = new TokenModel(tokenToSave);
                const saveResult = await saveObj.save();
                if (!saveResult) {
                    throw new Error('Error saving token');
                }
            } else {
                const saveResult = await TokenModel.findByIdAndUpdate(
                    { token: 'Bearer ' + encryptedToken },
                    { tokenToSave },
                    { new: true }
                );
                if (!saveResult) {
                    throw new Error('Error Updating token');
                }
            }
            await disconectMongo();
            this.logEvent('INFO', 'Token generated successfully', 2);
            return res.status(200).json({
                access_token: token,
                token_type: "bearer",
                expires_in: this.expiration
            });
        } catch (e) {
            this.logEvent('ERROR', `Error generating token ${e}`, 2);   
            return res.status(500).json({ message: `${this.tokenGenerationName('ERROR')} Error generating token ${e}` });
        }
    }

    async verifyClient(clientId, clientSecret) {
        try {
            this.logEvent('INFO', 'Verifying client...', 3);
            if (!clientId || !clientSecret) {
                this.logEvent('ERROR', 'Missing parameters', 3);
            }
            this.logEvent('INFO', 'Connecting to database...', 3);
            const findResult = await ApplicationModel.find({ clientId: clientId.trim() });
            if (!findResult) {
                throw new Error('Error: No applications found');
            }
            console.log(findResult);
            this.logEvent('INFO', 'Client verified successfully', 3);
            return true;
        } catch (error) {
            this.logEvent('ERROR', `Error verifying client ${error}`, 3);
            return false;
        }
    }
}

export default GenerateToken;