import express from 'express';
import timeout from 'connect-timeout';
import cors from 'cors';
import logger from './lib/Logger.js';
 


import MongoDBConnector from     './lib/MongooDB.js';
import { chargeData } from       './lib/dotenvExtractor.js';
import MSSQLConnector from     './lib/sqlConnection.js';
import { timeStamp } from        './utils/timeStampCst.js';
import generateTokenRoute from   './routes/createTokenRoute.js';
import verifyTokenRoute from     './routes/verifyTokenRoute.js';
import excecSpRoute from         './routes/execSpRouter.js'
import reportProcess from        './routes/processReportRoute.js';
import createReportRoute from './routes/createReportRoute.js';
import executorRouter from './routes/executorRoute.js'

import testing from              './routes/testingroute.js';

chargeData();
const app = express();
 

 
 const sqlConnector = new MSSQLConnector( );

const mongoDBConnector = new MongoDBConnector({
    url: process.argv[2],
    user: process.argv[3],
    pass: process.argv[4],
    dbName: process.argv[5]
});
 

const startServer = async () => {
    try {
        await mongoDBConnector.connect();
         await sqlConnector.connect();
   
        app.use(express.json());
        app.use(cors());
        app.use(express.urlencoded({ extended: true }));
        app.use('/oauth/token', generateTokenRoute); // Ensure the route is correctly set
        app.use('/oauth/verify', timeout('10s'), verifyTokenRoute); // Ensure the route is correctly set
        app.use('/generateReport',timeout('10s'),reportProcess);
        //app.use('/updateState',timeout('10s'),porcess);
        app.use('/createReport',timeout('10s'),createReportRoute);
        // app.use('/initReportProcess',timeout('10s'),creationProcess );    
        app.use('/exectSP',excecSpRoute);
        app.use('/',executorRouter);
        //  app.use('/oauth/newClient', timeout('10s'), createNewClientRoute); // Ensure the route is correctly set
        //  app.use('/saveReportData',timeout('10s'),testing);
        app.listen(process.argv[7],  () => {
            logger.info(`${timeStamp}[REPORT-ENGINE]-[SERVER]: Server is running on port http://127.0.0.1:${process.argv[7]}`);
           
        });
    } catch (err) {
        logger.error('Ocurrio un error', err);
        process.exit(1);
    }
};

startServer();