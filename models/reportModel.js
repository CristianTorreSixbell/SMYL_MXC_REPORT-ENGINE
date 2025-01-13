import mongoose from 'mongoose';
 
const { Schema } = mongoose;

 

 
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
    } 
});

// Index to automatically delete documents after 1 day
reportSchema.index({ expiration_date: 1 }, { expireAfterSeconds: 1300000 }); // Cada 750 MB aprox se limpian los datos en la db

const reportModel = mongoose.model('reports', reportSchema);

export  default  reportModel ;