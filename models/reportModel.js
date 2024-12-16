import mongoose from 'mongoose';
import { chargeData } from '../lib/dotenvExtractor.js';
chargeData();
const { Schema } = mongoose;
const encrypt = (text) => {
    const iv = crypto.randomBytes(16); // Initialization vector
    const cipher = crypto.createCipheriv('aes-256-cbc', Buffer.from(encryptionKey, 'utf8'), iv);
    let encrypted = cipher.update(text, 'utf8', 'hex');
    encrypted += cipher.final('hex');
    return iv.toString('hex') + ':' + encrypted; // Prepend IV for decryption
};

const tokenSchema = new Schema({
    dateTFind: {
        type: Date,
        required: true //select date
    },
    dateProcess: {
        type: Date,
        required: true // time stamp exec
    } ,
    reportId:{
        type: String,
        required: true // report id
    },
    state:{
        type: String,
        required: true // estado
    },
    result:{
        type: String,
        required: true // resultado  success/fail
    },
    file:{
        type: String,  
        required:false,
        set: encrypt // file  
    }
});

// Index to automatically delete documents after 1 day
intervalSchema.index({ expiration_date: 1 }, { expireAfterSeconds: 1300000 });// Cada 750 MB aprox se limpian los datos en la db

const reportModel = mongoose.model('report-model', tokenSchema);

export default reportModel;