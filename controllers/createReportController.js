import ObjectsToCsv from 'objects-to-csv';
import path from 'path';
import fs from 'fs';
import historicalModel from '../models/rawSqlData.js';
import reportModel from '../models/reportModel.js';
import eventLogModel from '../models/eventsLogs.js';
import logger from '../lib/Logger.js';
import { timeStamp2 } from '../utils/timeStampCst.js';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

class CreateReport {
    constructor() {
        this.folderName = 'static/reports';
        this.logEvent = (type, event, submoduleInd) => {
            const submodules = ['EXTRACT-REPORT-DATA', 'MAIN', 'CHECK-FOLDER'];
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
        this.extractReportData = this.extractReportData.bind(this);
        this.checkFolder = this.checkFolder.bind(this);
    }

    async extractReportData(req, res) {
        try {
            this.logEvent('INFO', 'Iniciando creación de reporte', 0);

            const { interval, reportID } = JSON.parse(JSON.stringify(req.body, null, 4));

            if (!interval || !reportID) {
                throw new Error(`No se pudo extraer el intervalo ${interval}`);
            }
            console.log('Intervalo =', interval);
            console.log('ReportID =', reportID);
            this.logEvent('INFO', `Verificando la creacion del reporte utilizando el Intervalo: ${interval} `, 0);
            const reportFindStatus= await reportModel.findOne({ reportId: reportID });
            console.log('REPORT FIND STATUS =',JSON.stringify(reportFindStatus, null, 4));
            if(reportFindStatus){
                if(reportFindStatus.state.toString().includes('done')){
                    return res.status(200).json({ "Msg": "Reporte ya creado" });
                }
                
            }
           

            let newEvent = new eventLogModel({
                "reportid": reportID,
                "event": `INFO`,
                "eventMsg": `[EXTRACT-REPORT-DATA]: Iniciando creación de reporte`,
                "eventDate": timeStamp2
            });
            await newEvent.save();

            const [initDate, endDate] = interval.split('/');
            if (!initDate || !endDate) {
                throw new Error(`No se pudo extraer el intervalo ${interval}`);
            }
            const findResult = await historicalModel.find({ "searchingPeriod": interval });
            if (!findResult || findResult.length < 1  ) {
                throw new Error('No se encontraron registros');
            }
            console.log(findResult[0].clientReporData)
            fs.writeFileSync('./test.json', JSON.stringify(findResult, null, 4));
            const creationRes = await this.generateCSV(findResult[0].clientReporData, initDate);
            const updateStatusRes = await reportModel.findOneAndUpdate(
                { reportId: reportID },
                {
                    $set: {
                        status: "in-progress",
                        result: "Generation in progress"
                    }
                },
                { new: true, upsert: true }
            );
            if (!updateStatusRes) {
                throw new Error('No se pudo actualizar el estado del reporte\nRevisar conexion a la base de datos Mongo-DB');
            }
            if (creationRes.status != 200) {
                const updateErrorStateRes = await reportModel.findOneAndUpdate(
                    { reportId: reportID },
                    {
                        $set: {
                            status: "error",
                            result: `Generation Error: ${creationRes.data}`
                        }
                    },
                    { new: true, upsert: true }
                );
                if (!updateErrorStateRes) {
                    throw new Error('No se pudo actualizar el estado del reporte\nRevisar conexion a la base de datos Mongo-DB');
                }
                throw new Error('No se pudo crear el archivo ' + creationRes.data);
            }
            const updateDoneStateRes = await reportModel.findOneAndUpdate(
                { reportId: reportID },
                {
                    $set: {
                        state: "done",
                        result: "Report generation process complete successfully"
                    }
                },
                { new: true, upsert: true }
            );
            //console.log('UPDATE RESULT =',JSON.stringify(updateDoneStateRes, null, 4));
            if (!updateDoneStateRes) {
                throw new Error('No se pudo actualizar el estado del reporte');
            }
            newEvent = new eventLogModel({
                "reportid": reportID,
                "event": `INFO`,
                "eventMsg": `[EXTRACT-REPORT-DATA]: Reporte creado con exito`,
                "eventDate": timeStamp2
            });
            await newEvent.save();
            this.logEvent('INFO', 'Reporte Creado correctamente..........', 0);
            return res.status(200).json({ "Msg": "Reporte creado con exito" });
        } catch (e) {
            this.logEvent('ERROR', `No se logró Crear el reporte${e},\n${JSON.stringify(e, null, 4)}`, 0);
            const { interval, reportID } = req.body;
            const newEvent = new eventLogModel({
                "reportid": reportID,
                "event": `ERROR`,
                "eventMsg": `[EXTRACT-REPORT-DATA]: El archivo de intervalo = ${interval} no se logro crear: ${e}`,
                "eventDate": timeStamp2
            });
            const saveResult = await newEvent.save();
            if (!saveResult) {
                return res.status(500).json({ "Msg": "error" + 'Problema al guardar el evento\nRevisar Mongo-DB' });
            }
            return res.status(500).json({ "Msg": "error" });

        }
    }

    async generateCSV(sqlData, initDate) {
        try {
            if (!sqlData || !initDate  ) {
                throw new Error('No se encontraron registros');
            }
            console.log(sqlData[0]);
            const jsonObjToSave = sqlData.filter(row => row !== null).map(row => ({
                "CASE_ID": row["CASE_ID"] || "NULL",
                "CONVERSATION INIT": row["CONVERSATION INIT"] || "NULL",
                "CONVERSATION END": row["CONVERSATION END"] || "NULL",
                "PARTICIPANT ID": row["PARTICIPANT ID"] || "NULL",
                "PARTICIPANT NAME": row["PARTICIPANT NAME"] || "NULL",
                "SESSION ID": row["SESSION ID"] || "NULL",
                "EMAIL ADDRESS FROM": row["EMAIL ADDRESS FROM"] || "NULL",
                "EMAIL ADDRESS TO": row["EMAIL ADDRESS TO"] || "NULL",
                "QUEUE ENTRY": row["QUEUE ENTRY"] || "NULL",
                "QUEUE EXIT": row["QUEUE EXIT"] || "NULL",
                "TOTAL QUEUE TIME": row["TOTAL QUEUE TIME"] || "NULL",
                "CLIENT INTERACTION INIT": row["CLIENT INTERACTION INIT"] || "NULL",
                "CLIENT INTERACTION END": row["CLIENT INTERACTION END"] || "NULL",
                "TOTAL CLIENT INTERACTION TIME": row["TOTAL CLIENT INTERACTION TIME"] || "NULL",
                "AGENT INTERACTION INIT": row["AGENT INTERACTION INIT"] || "NULL",
                "AGENT INTERACTION END": row["AGENT INTERACTION END"] || "NULL",
                "TOTAL AGENT TIME SPEND": row["TOTAL AGENT TIME SPEND"] || "NULL",
                "QUEUE ID": row["QUEUE ID"] || "NULL",
                "QUEUE NAME": row["QUEUE NAME"] || "NULL",
                "SUBJET": row["SUBJET"] || "NULL",
                "TRANSFER": row["TRANSFER"] || "NULL",
                "CONCLUIDO": row["CONCLUIDO"] || "NULL"
            }));
            const csv = new ObjectsToCsv(jsonObjToSave);

            const fileDate = initDate.split(' ')[0];
            const fileName = `SMNYL_EMAIL_REPORT_${fileDate}.csv`;
            const creationRes = this.checkFolder(fileName, await csv.toString());
            if (creationRes.status != 200) {
                throw new Error('No se pudo crear el archivo ' + creationRes.data);
            }
            return {
                "status": 200,
                "data": creationRes.data
            }
        } catch (e) {
            this.logEvent('ERROR', `No se logró extraer el intervalo desde la base datos ${e},\n${JSON.stringify(e, null, 4)}`, 0);
            return {
                "status": 500,
                "data": e
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
                "data": filePath
            };
        } catch (e) {
            this.logEvent('ERROR', `Error verificando/creando directorio o archivo:${JSON.stringify(e, null, 4)} ${e}`, 2);
            return {
                "status": 500,
                "data": e
            }
        }
    }

}
export default CreateReport;