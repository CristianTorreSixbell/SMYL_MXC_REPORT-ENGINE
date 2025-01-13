import mongoose from 'mongoose';
import crypto from 'crypto';
import { chargeData } from '../lib/dotenvExtractor.js';
chargeData();
const { Schema } = mongoose;

const encryptionKey = process.argv[6];

if (encryptionKey.length !== 32) {
    throw new Error('Invalid encryption key length. Key must be 32 bytes.');
}

const encrypt = (text) => {
    const iv = crypto.randomBytes(16); // Initialization vector
    const cipher = crypto.createCipheriv('aes-256-cbc', Buffer.from(encryptionKey, 'utf8'), iv);
    let encrypted = cipher.update(text, 'utf8', 'hex');
    encrypted += cipher.final('hex');
    return iv.toString('hex') + ':' + encrypted; // Prepend IV for decryption
};

const decrypt = (text) => {
    const textParts = text.split(':');
    const iv = Buffer.from(textParts.shift(), 'hex');
    const encryptedText = textParts.join(':');
    const decipher = crypto.createDecipheriv('aes-256-cbc', Buffer.from(encryptionKey, 'utf8'), iv);
    let decrypted = decipher.update(encryptedText, 'hex', 'utf8');
    decrypted += decipher.final('utf8');
    return decrypted;
};

const historicalSchema = new Schema({
    searchingPeriod: {
        type: String,
        required: true,
        unique: true,
     
    },
    clientReporData:  {
        type: Schema.Types.Mixed,
        required: true,
        set: encrypt,
        get: decrypt
    }
    
     
}, { toJSON: { getters: true }, toObject: { getters: true } });

historicalSchema.index({ expiration_date: 1 }, { expireAfterSeconds: parseInt(1300000 / 2) }); // Cada 375 MB aprox

const historicalModel = mongoose.model('historical', historicalSchema);

export default historicalModel;