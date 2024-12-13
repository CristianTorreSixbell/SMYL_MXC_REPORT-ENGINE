import mongoose from 'mongoose';
import crypto from 'crypto';
import { chargeData } from '../lib/dotenvExtractor.js';
chargeData();
const { Schema } = mongoose;

const encryptionKey = process.argv[6]; 
const iv = crypto.randomBytes(16); // Initialization vector

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
const tokenSchema = new Schema({
    token: {
        type: String,
        required: true,
        set: encrypt ,
        get: decrypt
    },
    expiration_date: {
        type: Date,
        required: true
    },
    client_name: {
        type: String,
        required: true,
        set: encrypt,
        get: decrypt
    }
}, {
    toJSON: { getters: true },
    toObject: { getters: true }
});

// Index to automatically delete documents after 1 day
tokenSchema.index({ expiration_date: 1 }, { expireAfterSeconds: 86400 });

const TokenModel = mongoose.model('Token', tokenSchema);

export default TokenModel;