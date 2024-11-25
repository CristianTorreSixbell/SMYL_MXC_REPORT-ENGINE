import express from 'express';
import { timeStamp } from './utils/timeStampCst.js';
import verifyTokenRouter from './routes/verifyTokenRoute.js';
import generateTokenRoute from './routes/generateTokenRoute.js';
import MongoDBConnector from './lib/MongooDB.js';
import { MONGO_URL, MONGO_USER, MONGO_PASS, MONGO_DB_NAME, ENCRYPTION_KEY,PORT } from './lib/dotenvExtractor.js';

const app = express();

const envParams={
    "MONGO_URL":MONGO_URL,
    "MONGO_USER":MONGO_USER,
    "MONGO_PASS":MONGO_PASS,
    "MONGO_DB_NAME":MONGO_DB_NAME,
    "ENCRYPTION_KEY":ENCRYPTION_KEY,
    "PORT":PORT
};

if( Object.values(envParams).filter(value => value === null || value === undefined ).length > 20){
    console.error(`${timeStamp}[REPORT-ENGINE]-[SERVER]: Missing environment variables`);
    process.exit(1);
}

   //  Encryption key
process.argv.push(process.env.MONGO_URL, process.env.MONGO_USER,process.env.MONGO_PASS,process.env.MONGO_DB_NAME,process.env.ENCRYPTION_KEY,process.env.PORT);
//console.log(JSON.stringify(JSON.stringify(process.argv)));
const mongoDBConnector = new MongoDBConnector({
    url: process.argv[2],
    user: process.argv[3],
    pass: process.argv[4],
    dbName: process.argv[5]
});

const startServer = async () => {
    try {
        await mongoDBConnector.connect();
        app.use('/verifyToken', verifyTokenRouter(process.argv[5]));
        app.use('/creteToken', generateTokenRoute(process.argv[5], process.argv[6]));
        app.listen(process.argv[7], () => {
            console.log(`${timeStamp}[REPORT-ENGINE]-[SERVER]: Server is running on port http://127.0.0.1:${process.argv[7]}`);
        });
    } catch (err) {
        console.error('Failed to connect to MongoDB', err);
        process.exit(1);
    }
};

startServer();  