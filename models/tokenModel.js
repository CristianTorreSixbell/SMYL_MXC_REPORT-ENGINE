import mongoose from 'mongoose';
import crypto from 'crypto';

const { Schema } = mongoose;

const encryptionKey = process.argv[6]; 

const encrypt = (text) => {
    const cipher = crypto.createCipher('aes-256-cbc', encryptionKey);
    let encrypted = cipher.update(text, 'utf8', 'hex');
    encrypted += cipher.final('hex');
    return encrypted;
};

const decrypt = (text) => {
    const decipher = crypto.createDecipher('aes-256-cbc', encryptionKey);
    let decrypted = decipher.update(text, 'hex', 'utf8');
    decrypted += decipher.final('utf8');
    return decrypted;
};

const tokenSchema = new Schema({
    token: {
        type: String,
        required: true,
        set: encrypt,
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