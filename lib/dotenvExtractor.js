import dotenv from 'dotenv';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

dotenv.config({ path: path.resolve(__dirname, '../.env') });

const {
    MONGO_URL,        // 2
    MONGO_USER,       // 3
    MONGO_PASS,       // 4
    MONGO_DB_NAME,    // 5
    ENCRYPTION_KEY,   // 6
    PORT,             // 7
    TOKEN_EXPIRATION, // 8
    SECRET_KEY,       // 9
    SQL_PASS,         // 10
    SQL_IP,           // 11
    SQL_PORT,         // 12
    SQL_USER,         // 13
    SQL_DB,           // 14
    EXECT_T,          // 15
    SELF_URL,         // 16  
    CREATION_ENDPOINT,// 17   
    SP_ENDPOINT,      // 18
    START_DATE        // 19
    
            
} = process.env;

const envArray = [
    MONGO_URL,        // 2
    MONGO_USER,       // 3
    MONGO_PASS,       // 4
    MONGO_DB_NAME,    // 5
    ENCRYPTION_KEY,   // 6
    PORT,             // 7
    TOKEN_EXPIRATION, // 8
    SECRET_KEY,       // 9
    SQL_PASS,         // 10
    SQL_IP,           // 11
    SQL_PORT,         // 12
    SQL_USER,         // 13
    SQL_DB,           // 14
    EXECT_T,          // 15
    SELF_URL,         // 16
    CREATION_ENDPOINT,// 17   
    SP_ENDPOINT,      // 18
    START_DATE        // 19
        
];

if (Object.values(envArray).filter(value => value === null || value === undefined).length > 0) {
    console.error(`${timeStamp}[REPORT-ENGINE]-[SERVER]: Missing environment variables`);
    process.exit(1);
}

  function chargeData(){
    try {
        envArray.forEach(col => {
            process.argv.push(col);
        });
  
    } catch (error) {
        console.error('Error loading data:', error);
    }
}
export {
    chargeData
}
 