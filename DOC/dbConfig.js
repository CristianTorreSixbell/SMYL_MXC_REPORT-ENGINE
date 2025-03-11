import mongoose from 'mongoose';
import {ApplicationModel} from '../models/clientApplicationModel.js';
import { chargeData } from '../lib/dotenvExtractor.js';
chargeData();
async function setupDatabase() {
    const uri = process.argv[2];  
    const pass = process.argv[4];
    const user = process.argv[3];
    const dbName = process.argv[5];

  
  
    try {
  
         await mongoose.connect(uri, {
            auth: {
                username: user,
                password: pass
            }, dbName
        });
        const applicationData = {
            clientId: '5yX4Htc0bTxA55-Z9KT8mQGjfgmJp-1sl6JxzJjXh1wC-fPb1hFJH3ibfh6',
            clientSecret: clientSecret
        };
        const newApplication = new ApplicationModel(applicationData);
        const saveResult = await newApplication.save();
        if(saveResult == undefined || saveResult.length < 1 ){
            console.log('No se logro crear la coleccion dentro de la db')
        }
      console.log("Base de datos configurada correctamente.");
      await mongoose.disconnect();
    } catch (error) {
      console.error(`Error configurando la base de datos: ${error.message}`);
    }
  }

  export {
    setupDatabase
  }
  await setupDatabase()