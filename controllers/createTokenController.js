import jwt from 'jsonwebtoken';
import logger from '../lib/Logger.js';
import crypto from 'crypto';
import TokenModel from '../models/tokenModel.js';
import { ApplicationModel } from '../models/clientApplicationModel.js';
import { chargeData } from '../lib/dotenvExtractor.js';

chargeData();

class GenerateToken {
    constructor() {
        this.logEvent = this.logEvent.bind(this);
        this.generateToken = this.generateToken.bind(this);
        this.verifyClient = this.verifyClient.bind(this);
        
        this.decryptToken = this.decryptToken.bind(this);

        this.tokenExpiration = 86400; // 1 day in seconds
        this.secretKey = process.argv[9] || null;
        this.encryptionKey = process.argv[6] || null;

        if (this.encryptionKey.length !== 32) {
            throw new Error('Invalid encryption key length. Key must be 32 bytes.');
        }
    }

    logEvent(type, event, submoduleInd) {
        const submodules = [
            'ENCRYPT-TOKEN',
            'DECRYPT-TOKEN',
            'GENERATE-TOKEN',
            'VERIFY-CLIENT'
        ];
        const moduleName = 'CREATE_TOKEN';
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
    }

   

    decryptToken(encryptedToken) {
        const textParts = encryptedToken.split(':');
        const iv = Buffer.from(textParts.shift(), 'hex');
        const encryptedText = textParts.join(':');
        const decipher = crypto.createDecipheriv('aes-256-cbc', Buffer.from(this.encryptionKey, 'utf8'), iv);
        let decrypted = decipher.update(encryptedText, 'hex', 'utf8');
        decrypted += decipher.final('utf8');
        this.logEvent('INFO', 'Token decrypted successfully', 1);
        return decrypted;
    }

    async generateToken(req, res) {
        try {
            if (!this.tokenExpiration || !this.secretKey || !this.encryptionKey) {
                throw new Error('Error: Invalid env params this.tokenExpiration' + this.tokenExpiration + ' this.secretKey ' + this.secretKey + ' this.encryptionKey ' + this.encryptionKey);
            }

            this.logEvent('INFO', 'Generating token...', 2);
            const authHeader = req.headers['authorization'];
            const encodedData = authHeader && authHeader.split(' ')[1];
            if (!encodedData) {
                this.logEvent('ERROR', 'Invalid Token body', 2);
                return res.status(400).json({ message: 'Invalid body' });
            }

            const decodedString = Buffer.from(encodedData, 'base64').toString('ascii');
            const [clientId, clientSecret, clientScope] = decodedString.split(':');
            if (!clientId || !clientSecret || !clientScope) {
                this.logEvent('ERROR', 'Missing parameters', 2);
                return res.status(400).json({ error: 'Invalid Parameters' });
            }
            const contentType = req.headers['content-type'];
            if (contentType !== 'application/x-www-form-urlencoded' || req.body.grant_type !== 'client_credentials') {
                return res.status(400).json({ error: 'Unsupported grant type or invalid content type' });
            }
            const introspectionResult = await this.verifyClient(clientId, clientSecret);
            if (!introspectionResult) {
                throw new Error('Error: Invalid Client');
            }
            const payload = { clientId, scope: clientScope, clientSecret: clientSecret };
            const options = { expiresIn: this.tokenExpiration, algorithm: 'HS256' };
            const token = jwt.sign(payload, this.secretKey, options);
            
            const findResult = await TokenModel.findOne({ token: 'Bearer ' + token });
            const tokenToSave = {
                "token": 'Bearer ' + token,
                "expiration_date": new Date(Date.now() + this.tokenExpiration * 1000),
                "client_name": clientId
            };
            if (!findResult) {
                const saveObj = new TokenModel(tokenToSave);
                const saveResult = await saveObj.save();
                if (!saveResult) {
                    throw new Error('Error saving token');
                }
            } else {
                const saveResult = await TokenModel.findByIdAndUpdate(
                    { token: 'Bearer ' + token },
                    { tokenToSave },
                    { new: true }
                );
                if (!saveResult) {
                    throw new Error('Error Updating token');
                }
            }
            this.logEvent('INFO', 'Token generated successfully', 2);
            return res.status(200).json({
                access_token: token,
                token_type: "bearer",
                expires_in: this.tokenExpiration
            });
        } catch (e) {
            this.logEvent('ERROR', `Error generating token ${e}`, 2);
            return res.status(500).json({ message: `Error generating token ${e}` });
        }
    }

    async verifyClient(clientId, clientSecret) {
        try {
            this.logEvent('INFO', 'Verifying client...', 3);
            if (!clientId || !clientSecret) {
                this.logEvent('ERROR', 'Missing parameters', 3);
                throw new Error('Missing parameters');
            }
           
            this.logEvent('INFO', 'Connecting to database...', 3);
            const findResult = await ApplicationModel.find({
                clientId: clientId.trim(),
                clientSecret: clientSecret.trim()
            });
            if (!findResult) {
                throw new Error('Error: No applications found');
            }
           
            this.logEvent('INFO', 'Client verified successfully', 3);
            return true;
        } catch (error) {
            this.logEvent('ERROR', `Error verifying client ${error}`, 3);
            return false;
        }
    }
}

export default GenerateToken;