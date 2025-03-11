// import sql from 'mssql';
// import XLSX from 'xlsx';
// import path from 'path';
// import { fileURLToPath } from 'url';
// import fs from 'fs';
// import logger from '../lib/Logger.js';
// import MSSQLConnector from '../lib/sqlConnection.js';
// const sqlConnector = new MSSQLConnector();
// const filename = fileURLToPath(import.meta.url);
// const __dirname = path.dirname(filename);

// class ExtractXlsxInfo {
//     constructor() {
//         this.forlderPath = path.join(__dirname, `./REPORTE_TEST_SMNYL.xlsx`);

//         this.logEvent = (type, event) => {
//             const moduleName = 'GET_XLSX_INFO';
//             if (type.toLowerCase().includes('error')) {
//                 logger.error(`[${moduleName}(${type})]: ${event}`);
//                 return;
//             }
//             if (type.toLowerCase().includes('info')) {
//                 logger.info(`[${moduleName}(${type})]: ${event}`);
//                 return;
//             }
//             if (type.toLowerCase().includes('warn')) {
//                 logger.warn(`[${moduleName}(${type})]: ${event}`);
//                 return;
//             } else {
//                 logger.warn(`[${moduleName}(${type})]: ${event}\n(Error en tipificación de log)`);
//                 return;
//             }
//         };
//     }

//     async extractXlsxInfo(objType) {
//         try {
//             if (!objType) {
//                 throw new Error('Tipo de objeto a crear no definido');
//             }
//             const fileData = XLSX.readFile(this.forlderPath);
//             const workbookSheets = fileData.SheetNames;
//             let sheetNumber = -1;
//             const sheetName = objType; // Nombre de la hoja que quieres obtener
//             for (const sheet of workbookSheets) {
//                 if (sheet.toLowerCase().includes(sheetName.toLowerCase())) {
//                     sheetNumber = workbookSheets.indexOf(sheet);
//                     break;
//                 }
//             }
//             if (sheetNumber < 0) {
//                 throw new Error(`No se encontró la hoja ${sheetName}`);
//             }
//             const selectedSheet = workbookSheets[sheetNumber]; // Accediendo a la hoja según nombre
//             const excelToJson = XLSX.utils.sheet_to_json(fileData.Sheets[selectedSheet], {
//                 raw: false,
//                 defval: ""
//             });
//             return {
//                 "status": 200,
//                 "data": excelToJson
//             };
//         } catch (error) {
//             this.logEvent('ERROR', `Error al extraer información del archivo ${error}`);
//             return {
//                 "status": 500,
//                 "data": `Error al extraer información del archivo ${error}`
//             };
//         }
//     }
// }

// export default ExtractXlsxInfo;
// const getXlsxInfo = new ExtractXlsxInfo();
// const result = await getXlsxInfo.extractXlsxInfo('hoja 1');

// function delay(ms) {
//     return new Promise(resolve => setTimeout(resolve, ms));
// }

// const processedData = [];
// const backupFilePath = path.join(__dirname, 'respaldo.json');

// // Inicializar el archivo de respaldo como un array vacío
// fs.writeFileSync(backupFilePath, '[]');

// for (const row of result.data) {
//     await sqlConnector.connect();
//     const conversationID = row["__EMPTY"];
//     if (conversationID?.includes("CASE_ID")) {
//         continue;
//     }

//     const sesionID = row["__EMPTY_5"];
//     const participantID = row["__EMPTY_3"];

//     let subjetc = null;
//     let conclusion = null;
//     let transfer = null;
//     let queueName = null;
//     let queueID = null;

//     const request = new sql.Request();
// dd

//     if (sesionID !== 'NULL' && sesionID !== undefined && conversationID !== 'NULL' && conversationID !== undefined && participantID !== 'NULL' && participantID !== undefined) {
//         try {
//             const getQueueInfoQ = `EXEC GetQueueInfoByConversation '${conversationID}' ,'${sesionID}','${participantID}' `;
//             const getQueueInfoResult = await request.query(getQueueInfoQ);
//             queueID =   getQueueInfoResult.recordset[0]?.colaId || null;
//             queueName = getQueueInfoResult.recordset[0]?.colaName || null;
//         } catch (e) {
//             throw new Error(`Error al momento de ejecutar el sp GetQueueInfoByConversation ${e}`);
//         }
//     }

//     if (sesionID !== 'NULL ' && sesionID !== undefined && participantID !== 'NULL' && participantID !== undefined) {
//         try {
//             const queryTransfer = `EXEC GetTransferOrNot '${participantID}', '${sesionID}' `;
//             const queryResult = await request.query(queryTransfer);
//             transfer = queryResult.recordset[0]?.transfer || null;
//             const doneQuery = `EXEC DoneOrNot '${participantID}', '${sesionID}'  ;`;
//             const doneQueryResult = await request.query(doneQuery);
//             conclusion = doneQueryResult.recordset[0]?.done || null;
//         } catch (e) {
//             throw new Error(`Error al momento de ejecutar el sp GetTransferOrNot ${e}`);
//         }
//     }

//     const jsontoSave = {
//         "CASE_ID": conversationID || null,
//         "CONVERSATION INIT": row["__EMPTY_1"] || null,
//         "CONVERSATION END": row["__EMPTY_2"] || null,
//         "PARTICIPANT ID": participantID || null,
//         "PARTICIPANT NAME": row["__EMPTY_4"] || null,
//         "SESSION ID": sesionID || null,
//         "EMAIL ADDRESS FROM": row["__EMPTY_6"] || null,
//         "EMAIL ADDRESS TO": row["__EMPTY_7"] || null,
//         "QUEUE ENTRY": row["__EMPTY_8"] || null,
//         "QUEUE EXIT": row["__EMPTY_9"] || null,
//         "TOTAL QUEUE TIME": row["__EMPTY_10"] || null,
//         "CLIENT INTERACTION INIT": row["__EMPTY_11"] || null,
//         "CLIENT INTERACTION END": row["__EMPTY_12"] || null,
//         "TOTAL CLIENT INTERACTION TIME": row["__EMPTY_13"] || null,
//         "AGENT ITERACTION INIT": row["__EMPTY_14"] || null,
//         "AGENT INTERACTION END": row["__EMPTY_15"] || null,
//         "TOTAL AGENT TIME SPEND": row["__EMPTY_16"] || null,
//         "QUEUE ID": queueID || 'NULL',
//         "QUEUE NAME": queueName || 'NULL',
//         "SUBJET": subjetc || 'NULL',
//         "TRANSFER": transfer || 'NULL',
//         "CONCLUIDO": conclusion || 'NULL'
//     };

//     console.log(jsontoSave);
//     processedData.push(jsontoSave);

//     // Leer el contenido actual del archivo de respaldo
//     const backupData = JSON.parse(fs.readFileSync(backupFilePath, 'utf8'));

//     // Añadir el nuevo objeto al array
//     backupData.push(jsontoSave);

//     // Escribir el array actualizado de nuevo en el archivo de respaldo
//     fs.writeFileSync(backupFilePath, JSON.stringify(backupData, null, 2));

//     await delay(100);
// }

// // Crear un nuevo archivo XLSX con los datos procesados
// const newWorkbook = XLSX.utils.book_new();
// const newWorksheet = XLSX.utils.json_to_sheet(processedData);
// XLSX.utils.book_append_sheet(newWorkbook, newWorksheet, 'Processed Data');
// XLSX.writeFile(newWorkbook, path.join(__dirname, 'Processed_Report.xlsx'));

// console.log('Archivo XLSX generado con éxito.');

import historicalModel from '../models/rawSqlData.js';
import { chargeData } from '../lib/dotenvExtractor.js';
import MongoDBConnector from '../lib/MongooDB.js';  
import fs from 'fs';
chargeData();

const mongoConnector = new MongoDBConnector({
    url:    process.argv[2],
    user:   process.argv[ 3],
    pass:   process.argv[ 4],
    dbName: process.argv[ 5] 
});

await mongoConnector.connect();

const request = await historicalModel.find({});
const uniqueRequest = Array.from(new Set(request.map(JSON.stringify))).map(JSON.parse);

fs.writeFileSync('./data_2.json', JSON.stringify(uniqueRequest, null, 2), 'utf8');
let cnt = 0; 
for (const row of uniqueRequest[0].clientReporData) {
    cnt++;  
}
console.log(cnt);