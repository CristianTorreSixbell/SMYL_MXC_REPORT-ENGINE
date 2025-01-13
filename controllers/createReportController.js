import ObjectsToCsv from 'objects-to-csv';
import path from 'path';
import fs from 'fs';
import historicalModel from '../models/rawSqlData.js';
import reportModel from '../models/reportModel.js';
import eventLogModel from '../models/eventsLogs.js'
import {timeStamp} from '../utils/timeStampCst.js';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);







class createReport{
    constructor (){
        this.folderName='static'
        this.logEvent = (type, event, submoduleInd) => {
            const submodules = ['EXTRACT-REPORT-DATA', 'MAIN','CHECK-FOLDER'];
            const moduleName = 'CREATE_REPORT';
            const submodule = parseInt(submoduleInd) ? `][${submodules[parseInt(submoduleInd)]}` : '';
            
            if (type.toLowerCase().includes('error')) {
                logger.error(`[${moduleName}${submodule}(${type})]: ${event}`);
                return;
            }
            if (type.toLowerCase().includes('info')) {
                logger.info(`[${moduleName}${submodule}(${type})]: ${event}`);
                return;
            }
            if (type.toLowerCase().includes('warn')) {
                logger.warn(`[${moduleName}${submodule}(${type})]: ${event}`);
                return;
            } else {
                logger.warn(`[${moduleName}${submodule}(${type})]: ${event}\n(Error en tipificación de log)`);
                return;
            }
        };
        this.extractReportData= this.extractReportData.bind(this);
        this.checkFolder= this.checkFolder.bind(this);
     }
    async extractReportData(req, res){
       try{
            this.logEvent('INFO', 'Iniciando creación de reporte', 0);
            let newEvent=new eventLogModel({
                "reportid":reportID,
                "event":`INFO`,
                "eventMsg": `[EXTRACT-REPORT-DATA]: Iniciando creación de reporte`,
                "eventDate": timeStamp
            });
            await newEvent.save();
            const {interval,reportID} = req.body;
            if(!!interval || !reportID){
                throw new Error(`No se pudo extraer el intervalo ${interval}`);
           }
            const [initDate, endDate] = interval.split('/');
            if( !initDate || !endDate){
                throw new Error(`No se pudo extraer el intervalo ${interval}`); 
            }
            const findResult=await historicalModel.find({"searchingPeriod":interval});
            if(! findResult || findResult.length < 1 || findResult.filter((element) => element  == null).length >= 1  ){
                throw new Error('No se encontraron registros');
            }
           
            const creationRes= this.generateCSV(findResult[0] ,initDate);
            const updateStatusRes=await reportModel.findOneAndUpdate(
                {reportId:reportID},
                {$set:{
                    status: "in-progress",
                }},
                { new: true, upsert: true }
            );
            if(updateStatusRes.length < 1 || updateStatusRes.filter((element) => element == null).length >= 1){
                throw new Error('No se pudo actualizar el estado del reporte\nRevisar conexion a la base de datos Mongo-DB');
            }
            if(creationRes.status !=200){
                const updateErrorStateRes=await reportModel.findOneAndUpdate(
                    {reportId:reportID},
                    {$set:{
                        status: "error",
                    }},
                    { new: true, upsert: true }
                );
                if(updateErrorStateRes.updateErrorStateRes < 1 || updateErrorStateRes.filter((element) => element == null).length >= 1){
                    throw new Error('No se pudo actualizar el estado del reporte\nRevisar conexion a la base de datos Mongo-DB');
                }
                throw new Error('No se pudo crear el archivo '+ creationRes.data);
            }   
            const updateDoneStateRes=await reportModel.findOneAndUpdate(
                {reportId:reportID},
                {$set:{
                    status: "done",
                }},
                { new: true, upsert: true }
            );
            if(updateDoneStateRes.updateDoneStateRes < 1 || updateDoneStateRes.filter((element) => element == null).length >= 1){
                throw new Error('No se pudo actualizar el estado del reporte');

            }
            newEvent=new eventLogModel({
                "reportid":reportID,
                "event":`INFO`,
                "eventMsg": `[EXTRACT-REPORT-DATA]: Reporte creado con exito`,
                "eventDate": timeStamp
            });
            await newEvent.save();
            this.logEvent('INFO', 'Reporte Creado correctamente..........', 0);
            return res.status(200).json({"Msg":"Reporte creado con exito"});
        }catch(e){
            this.logEvent('ERROR', `No se logró Crear el reporte${e},\n${JSON.stringify(e, null, 4)}`, 0);
            const {interval,reportID} = req.body;
            const newEvent=new eventLogModel({
                "reportid":reportID,
                "event":`ERROR`,
                "eventMsg": `[EXTRACT-REPORT-DATA]: El archivo de intervalo = ${interval} no se logro crear: ${e}`,
                "eventDate": timeStamp
            });
            const saveResult=await newEvent.save();
            if(saveResult.length < 1 || saveResult.filter((element) => element == null).length >= 1){
                return res.status(500).json({"Msg":"error"+'Problema al guardar el evento\nRevisar Mongo-DB'});
            }
            return res.status(500).json({"Msg":"error"});
            
        }
    }
    async generateCSV(sqlData,initDate){
        try {
            if(!sqlData||!initDate||sqlData.filter((element) => element !== null).length  < 1){
                throw new Error('No se encontraron registros');
            }
            for(const row of sqlData ){
                if(!row){
                    throw new Error('No se encontraron registros');
                }
                console.log('Fila = ',row);
                const jsonObjToSave={
                    "CASE_ID":                      row["CASE_ID"],
                    "CONVERSATION INIT":            row["CONVERSATION INIT"],
                    "CONVERSATION END":             row["CONVERSATION END"],
                    "PARTICIPANT ID":               row["PARTICIPANT ID"],
                    "PARTICIPANT NAME":             row["PARTICIPANT NAME"],
                    "SESSION ID":                   row["SESSION ID"],
                    "EMAIL ADDRESS FROM":           row["EMAIL ADDRESS FROM"],
                    "EMAIL ADDRESS TO":             row["EMAIL ADDRESS TO"],
                    "QUEUE ENTRY":                  row["QUEUE ENTRY"],
                    "QUEUE EXIT":                   row["QUEUE EXIT"],
                    "TOTAL QUEUE TIME":             row["TOTAL QUEUE TIME"],
                    "CLIENT INTERACTION INIT":      row["CLIENT INTERACTION INIT"],
                    "CLIENT INTERACTION END	":      row["CLIENT INTERACTION END"],
                    "TOTAL CLIENT INTERACTION TIME":row["TOTAL CLIENT INTERACTION TIME"],
                    "AGENT ITERACTION INIT":        row["AGENT ITERACTION INIT"],
                    "AGENT INTERACTION END":        row["AGENT INTERACTION END"],
                    "TOTAL AGENT TIME SPEND":       row["TOTAL AGENT TIME SPEND"],
                    "QUEUE ID":                     row["QUEUE ID"],
                    "QUEUE NAME":                   row["QUEUE NAME"],
                    "SUBJET":                       row["SUBJET"],
                    "TRANSFER":                     row["TRANSFER"],
                    "CONCLUIDO":                    row["CONCLUIDO"]
                };
                const csv = new ObjectsToCsv(jsonObjToSave.map(item => ({
                    "CASE_ID":                      item["CASE_ID"],
                    "CONVERSATION INIT":            item["CONVERSATION INIT"],
                    "CONVERSATION END":             item["CONVERSATION END"],
                    "PARTICIPANT ID":               item["PARTICIPANT ID"],
                    "PARTICIPANT NAME":             item["PARTICIPANT NAME"],
                    "SESSION ID":                   item["SESSION ID"],
                    "EMAIL ADDRESS FROM":           item["EMAIL ADDRESS FROM"],
                    "EMAIL ADDRESS TO":             item["EMAIL ADDRESS TO"],
                    "QUEUE ENTRY":                  item["QUEUE ENTRY"],
                    "QUEUE EXIT":                   item["QUEUE EXIT"],
                    "TOTAL QUEUE TIME":             item["TOTAL QUEUE TIME"],
                    "CLIENT INTERACTION INIT":      item["CLIENT INTERACTION INIT"],
                    "CLIENT INTERACTION END":       item["CLIENT INTERACTION END	"],
                    "TOTAL CLIENT INTERACTION TIME":item["TOTAL CLIENT INTERACTION TIME"],
                    "AGENT ITERACTION INIT":        item["AGENT ITERACTION INIT"],
                    "AGENT INTERACTION END":        item["AGENT INTERACTION END"],
                    "TOTAL AGENT TIME SPEND":       item["TOTAL AGENT TIME SPEND"],
                    "QUEUE ID":                     item["QUEUE ID"],
                    "QUEUE NAME":                   item["QUEUE NAME"],
                    "SUBJET":                       item["SUBJET"],
                    "TRANSFER":                     item["TRANSFER"],
                    "CONCLUIDO":                    item["CONCLUIDO"]
                })));
                
                const fileDate = initDate.split(' ')[0];
                const fileName=`SMNYL_EMAIL_REPORT_${fileDate}.csv`;
                const creationRes= this.checkFolder(fileName,csv);
                if(creationRes.status !=200){
                    throw new Error('No se pudo crear el archivo '+ creationRes.data);
                }
                return {
                    "status":200,
                    "data":creationRes.data 
                }
            }
        } catch (error) {
            this.logEvent('ERROR', `No se logró extraer el intervalo desde la base datos ${e},\n${JSON.stringify(e, null, 4)}`, 0);
            return {
                "status":500,
                "data":error
            }
        }
    }     
    checkFolder(filename, fileData) {
        try {
            this.logEvent('INFO', 'Verificando existencia de directorio..........', 2);
            if (!filename) {
                throw new Error('No se encontró el nombre del archivo');
            }

            const folderPath = path.join(__dirname, '../' + this.folderName);
            if (!fs.existsSync(folderPath)) {
                fs.mkdirSync(folderPath, { recursive: true });
                this.logEvent('INFO', `Directorio creado: ${folderPath}`, 2);
            }

            let filePath = path.join(folderPath, filename);
            let fileCount = 1;

            while (fs.existsSync(filePath)) {
                const ext = path.extname(filename);
                const baseName = path.basename(filename, ext);
                filePath = path.join(folderPath, `${baseName}_${fileCount}${ext}`);
                fileCount++;
            }

            this.logEvent('INFO', `Archivo a crear: ${filePath}`, 2);

            fs.writeFileSync(filePath, fileData);
            this.logEvent('INFO', `Archivo creado: ${filePath}`, 2);
            return {
                "status": 200,
                "data":filePath
            };
        } catch (e) {
            this.logEvent('ERROR', `Error verificando/creando directorio o archivo:${JSON.stringify(e,null,4)} ${e}`, 2);
            return{
                "status": 500,
                "data":e
            }
        }
    }

}
export default createReport;