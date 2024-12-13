import logger from '../lib/Logger.js';
import crypto from 'crypto';
import { ApplicationModel } from '../models/clientApplicationModel.js';
import { chargeData } from '../lib/dotenvExtractor.js';

chargeData();

class InsertApplication {
    constructor() {
        this.logEvent = this.logEvent.bind(this);
        this.insertApplication = this.insertApplication.bind(this);
        // this.encrypt = this.encrypt.bind(this);
        // this.decrypt = this.decrypt.bind(this);

        this.encryptionKey = process.argv[6] || null;

        if (this.encryptionKey.length !== 32) {
            throw new Error('Invalid encryption key length. Key must be 32 bytes.');
        }
    }

    logEvent(type, event, submoduleInd) {
        const submodules = [
            'ENCRYPT-DATA',
            'DECRYPT-DATA',
            'INSERT-APPLICATION'
        ];
        const moduleName = 'INSERT_APPLICATION';
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

    // encrypt(text) {
    //     try {
    //         const iv = crypto.randomBytes(16);
    //         const cipher = crypto.createCipheriv('aes-256-cbc', Buffer.from(this.encryptionKey, 'utf8'), iv);
    //         let encrypted = cipher.update(text, 'utf8', 'hex');
    //         encrypted += cipher.final('hex');
    //         this.logEvent('INFO', 'Data encrypted successfully', 0);
    //         return iv.toString('hex') + ':' + encrypted;
    //     } catch (e) {
    //         this.logEvent('ERROR', `Error encrypting data ${e}`, 0);
    //         console.log(e);
    //         console.log(JSON.stringify(e, null, 4));
    //         return null;
    //     }
    // }

    // decrypt(encryptedText) {
    //     const textParts = encryptedText.split(':');
    //     const iv = Buffer.from(textParts.shift(), 'hex');
    //     const encryptedData = textParts.join(':');
    //     const decipher = crypto.createDecipheriv('aes-256-cbc', Buffer.from(this.encryptionKey, 'utf8'), iv);
    //     let decrypted = decipher.update(encryptedData, 'hex', 'utf8');
    //     decrypted += decipher.final('utf8');
    //     this.logEvent('INFO', 'Data decrypted successfully', 1);
    //     return decrypted;
    // }

    async insertApplication(req, res) {
        try {
            const { clientId, clientSecret } = req.body;

            if (!clientId || !clientSecret) {
                this.logEvent('ERROR', 'Missing parameters', 2);
                return res.status(400).json({ error: 'Invalid Parameters' });
            }

            this.logEvent('INFO', 'Inserting application...', 2);

       

            const applicationData = {
                clientId: clientId,
                clientSecret: clientSecret
            };

            const newApplication = new ApplicationModel(applicationData);
            const saveResult = await newApplication.save();

            if (!saveResult) {
                throw new Error('Error saving application');
            }

            this.logEvent('INFO', 'Application inserted successfully', 2);
            return res.status(200).json({ message: 'Application inserted successfully' });
        } catch (e) {
            this.logEvent('ERROR', `Error inserting application ${e}`, 2);
            return res.status(500).json({ message: `Error inserting application ${e}` });
        }
    }
}

export default InsertApplication;