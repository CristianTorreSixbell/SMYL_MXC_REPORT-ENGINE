import mongoose from 'mongoose';
import crypto from 'crypto';
import { chargeData } from '../lib/dotenvExtractor.js';
chargeData();
const { Schema } = mongoose;

const encryptionKey = process.env.ENCRYPTION_KEY;

const encrypt = (text) => {
    const iv = crypto.randomBytes(16); // Initialization vector
    const cipher = crypto.createCipheriv('aes-256-cbc', Buffer.from(encryptionKey, 'utf8'), iv);
    let encrypted = cipher.update(text, 'utf8', 'hex');
    encrypted += cipher.final('hex');
    return iv.toString('hex') + ':' + encrypted; // Prepend IV for decryption
};

const reportSchema = new Schema({
    datesTFind: {
        type: String, // Cambiado a String para reflejar el formato en la base de datos
        required: true,
        unique: true    //select date
    },
    dateProcess: {
        type: Date,
        required: true  // time stamp exec
    },
    reportId: {
        type: String,
        required: true, // report id
        unique: true
    },
    state: {
        type: String,
        required: true  // estado
    },
    result: {
        type: String,
        required: true  // resultado  success/fail
    },
    file: {
        type: String,
        required: false,
        set: encrypt    // file  
    }
});

// Index to automatically delete documents after 1 day
reportSchema.index({ expiration_date: 1 }, { expireAfterSeconds: 1300000 }); // Cada 750 MB aprox se limpian los datos en la db

const reportModel = mongoose.model('reports', reportSchema);

export  default  reportModel ;