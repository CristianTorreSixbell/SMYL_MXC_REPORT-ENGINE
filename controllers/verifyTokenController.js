import jwt from 'jsonwebtoken';
import logger from '../lib/Logger.js';
 
//import { connectTo, disconectMongo } from '../utils/mongoDb.js';
import crypto from 'crypto';

class VerifyToken {
    constructor(encryptionKey) {
        this.logEvent = (type, event, submoduleInd) => {
            const submodules = ['DECRYPT-TOKEN', 'VERIFY-TOKEN', 'VERIFY-TENENT-IN-CONFIG', 'VERIFY-TENENT-IN-OAUTH'];
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
        
        this.secretKey = encryptionKey;
        this.encryptionKey = encryptionKey;
        this.verifyNameFunctionEvent = (event) => `[verifyToken(${event})]:`;
        this.verifyClientName = (event) => `[verifyClient(${event})]:`;
        this.verifyToken = this.verifyToken.bind(this);
        this.insightConfigDb = 'Insight_Config';
        this.insightOauthDb = 'Insight_Oauth';
        this.verifyTenantInConfig = this.verifyTenantInConfig.bind(this);
        this.secondCollection = 'tenants';
    }

    decryptToken(encryptedToken) {
        this.logEvent('INFO', 'Decrypting token...', 0);
        const decipher = crypto.createDecipher('aes-256-cbc', this.encryptionKey);
        let decrypted = decipher.update(encryptedToken, 'hex', 'utf8');
        decrypted += decipher.final('utf8');
        this.logEvent('INFO', 'Token decrypted successfully', 0);
        return decrypted;
    }

    async verifyToken(req, res) {
        try {
            this.logEvent('INFO', 'Verifying token...', 1);

            const encryptedToken = req.headers['authorization'].split('Bearer ')[1].trim();
            const token = this.decryptToken(encryptedToken);

            this.logEvent('INFO',`Token recibido correctamente\nEvaluando...`,1);

            const decoded = jwt.verify(token, this.secretKey);        
            const clientSecret = decoded.clientSecret;
            const clientId = decoded.clientId;
            const scope = decoded.scope;
            
            const configResult = await this.verifyTenantInConfig(clientId, clientSecret);
            const oauthResult = await this.verifyTenantInOauth(clientId, clientSecret);
            if (configResult.status !== 200 || oauthResult.status !== 200) {
                throw new Error('Error verifying client');
            }
            const combinedResponse = {
                message: 'Token verified successfully',
                decoded: decoded,
                configResult: configResult.data,
                oauthResult: oauthResult.data
            };
            const encodedResponse = jwt.sign(combinedResponse, this.secretKey, { expiresIn: '1h' });        
            return res.status(200).json({ encodedResponse });
        } catch (error) {
            logger.error(`${this.verifyNameFunctionEvent('ERROR')} Error verifying token: ${error}`);
            return res.status(401).json({ message: 'Invalid token' });
        }
    }

    async verifyTenantInConfig(clientId, clientSecret) {
        try {
            if (!clientId || !clientSecret || !this.insightConfigDb) {
                throw new Error('Invalid parameters');
            }
            this.logEvent('INFO', 'Verifying client...', 2);
            await connectTo(this.insightConfigDb);
            const findResult = await ConfigTenantModel.find({ clientId: clientId });
            if (!findResult) {
                throw new Error('Client not found');
            }
            const configModules = findResult[0].modules;
            await disconectMongo();
            this.logEvent('INFO', 'Client verified successfully', 2);

            return {
                status: 200,
                data: configModules
            };

        } catch (e) {
 
            this.logEvent('ERROR', `Error verifying client: ${e}`, 2);
            return {
                status: 500,
                data: `[verifyClient(Error)]: (" Error verifying client ${e} ")`
            };
        }
    }

    async verifyTenantInOauth(clientId, clientSecret) {
        try {
            if (!clientId || !clientSecret || !this.insightOauthDb) {
                throw new Error('Invalid parameters');
            }
            logger.info(`${this.verifyClientName('INFO')} Verifying client...`);
            const connectionResult = await connectTo(this.insightOauthDb);
            if (connectionResult.status !== 200) {
                throw new Error('Error connecting to database');
            }
            const client = connectionResult.data;
            const collection = client.connection.collection(this.secondCollection);
            const findResult = await collection.findOne({ clientId: clientId });
            if (!findResult) {
                throw new Error('Client not found');
            }
            this.logEvent('INFO', 'Client verified successfully', 3);
            const genesysOauth = findResult.GenesysOAuth;
            const mongoConfig = findResult.mongoConfig;
            console.log(genesysOauth);
            if (!genesysOauth || !mongoConfig) {
                throw new Error('Error fetching client data');
            }
            await disconectMongo();
            this.logEvent('INFO', 'Client verified successfully', 3);
            return {
                status: 200,
                data: {
                    genesysOauth: genesysOauth,
                    mongoConfig: mongoConfig
                }
            };
        } catch (error) {
            this.logEvent('ERROR', `Error verifying client: ${error}`, 3);
            return {
                status: 500,
                data: `[verifyClient(Error)]: (" Error verifying client ${error} ")`
            };
        }
    }
}

export default VerifyToken;