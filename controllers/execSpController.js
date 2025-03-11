import fs from 'fs';
import sql from 'mssql';
import crypto from 'crypto';
import cron from 'node-cron';
import path from 'path';
import { fileURLToPath } from 'url';
import timezone from 'dayjs/plugin/timezone.js';
import utc from 'dayjs/plugin/utc.js';
import dayjs from 'dayjs';
import logger from '../lib/Logger.js';
import { Worker } from 'worker_threads';

import { chargeData } from '../lib/dotenvExtractor.js';
import historicalModel from '../models/rawSqlData.js';
import reportModel from '../models/reportModel.js';

chargeData();
dayjs.extend(utc);
dayjs.extend(timezone);
dayjs.tz.setDefault('America/Chicago');
const fechaMexico = dayjs().subtract(6, 'hours').format("YYYY-MM-DD");
const __dirname = path.dirname(fileURLToPath(import.meta.url)); // Path actual

const generateUniqueId = (length = 32) => {
    return crypto.randomBytes(length).toString('hex');
};

const workerPath = path.resolve(__dirname, '../workers/queryExecWorker.js');

class ExectSp {
    constructor() {
        this.logEvent = (type, event, submoduleInd) => {
            const submodules = ['MAIN', 'EXEC-QUERY', 'GET-DATES', 'VERIFY-SP'];
            const moduleName = 'EXEC_SP';
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
 
        this.execQuery = this.execQuery.bind(this);
        this.uniqueId = generateUniqueId();
        this.checkSPinDB = this.checkSPinDB.bind(this);
        this.exectSp = this.exectSp.bind(this);
        this.spLocation = path.join(__dirname, '../static/sql-obj/sp2.sql');
        this.run = this.run.bind(this);
        this.runWorker = this.runWorker.bind(this);
    }

    async exectSp(req, res) { // Funcion principal, alimentando data historica
        try {
            const initDate = req.body.initDate ? new Date(req.body.initDate).toISOString() : new Date(dayjs().subtract(2, 'days').utc().startOf('day').format()).toISOString();
            const endDefaultDate = req.body.endDate ? new Date(req.body.endDate).toISOString() : new Date(dayjs().subtract(1, 'days').utc().endOf('day').format()).toISOString();
            const spCheckResult = await this.checkSPinDB();
            if (spCheckResult.status.toUpperCase() !== 'OK') {
                throw new Error('No se logro verificar la existencia del SP');
            }

            // Obtener el primer y último reporte para determinar el rango de fechas
            let firstReport = await reportModel.findOne().sort({ datesTFind: 1 });
            let lastReport = await reportModel.findOne().sort({ datesTFind: -1 });

            if (!firstReport || !lastReport) {
                this.logEvent('WARN', 'No se encontraron reportes en la base de datos', 0);
                this.logEvent('WARN', 'Tomando fecha por defecto', 0);
                firstReport = { datesTFind: `${initDate} / ${initDate}` };
                lastReport = { datesTFind: `${endDefaultDate} / ${endDefaultDate}` };
            }

            const startDate = dayjs(firstReport.datesTFind.split(' / ')[0]);
            const endDate = dayjs().subtract(1, 'day'); // Hasta el día actual -1

            // Procesar cada día en el rango de fechas
            for (let date = startDate; date.isBefore(endDate); date = date.add(1, 'day')) {
                const day = date.format("YYYY-MM-DD");
                const nextDay = date.add(1, 'day').format("YYYY-MM-DD");

                const selectRst = await historicalModel.find({ searchingPeriod: `${day} / ${nextDay}` });
                const selectReports = await reportModel.find({ datesTFind: `${day} / ${nextDay}` });

                if (selectRst.length > 0 || selectReports.length > 0) {
                    this.logEvent('INFO', `Ya se almaceno la informacion para este periodo! ${day}`, 0);
                    continue;
                }

                const allDayData = [];
                let cnt = 0;

                const startDay = date.startOf('day').format("YYYY-MM-DD HH:mm:ss");
                const endDay = date.endOf('day').format("YYYY-MM-DD HH:mm:ss");
                
                const queryRes = await this.execQuery(startDay, endDay);
                
                const data = queryRes.data.recordset;
                const batchSize = 50; // Tamaño del lote
                for (let i = 0; i < data.length; i += batchSize) {
                    const batch = data.slice(i, i + batchSize);
                    const workerResult = await this.run(batch);
                    this.logEvent('INFO', `Worker ${cnt} ejecutado con éxito`, 0);
                    allDayData.push(...workerResult); // Asegúrate de agregar los resultados correctamente
                    fs.writeFileSync(path.join(__dirname, `./data.json`), JSON.stringify(allDayData, null, 4), 'utf8');
                }

                const newHistoricalData = new historicalModel({
                    "searchingPeriod": `${day} / ${nextDay}`,
                    "clientReporData": allDayData
                });

                const saveResult = await historicalModel.findOneAndUpdate(
                    { searchingPeriod: `${day} / ${nextDay}` },
                    newHistoricalData,
                    { upsert: true, new: true }
                );
                if (!saveResult) {
                    throw new Error('No se logro guardar la data');
                }

                this.logEvent('INFO', `Data guardada con éxito`, 0);

                const reportSchema = {
                    "datesTFind": `${day} / ${nextDay}`,
                    "dateProcess": new Date(fechaMexico).toISOString(),
                    "reportId": this.uniqueId,
                    "state": "ready-to",
                    "result": "Data saved in transitory collection"
                };

                const saveReportResult = await reportModel.findOneAndUpdate(
                    { datesTFind: `${day} / ${nextDay}` },
                    reportSchema,
                    { upsert: true, new: true }
                );
                if (!saveReportResult) {
                    throw new Error('No se logro guardar el reporte');
                }
            }

            if (res) {
                return res.status(200).send("Información procesada con éxito");
            }
        } catch (e) {
            this.logEvent('ERROR ', `No se logro completar la ejecución del sp ${e}\n${JSON.stringify(e, null, 4)}`, 0);
            if (res) {
                return res.status(500).send('EXEC Error ' + e);
            }
        }
    }

    async runWorker(workerData) {
        return new Promise((resolve, reject) => {
            const worker = new Worker(workerPath, { workerData });
            worker.on('message', resolve);
            worker.on('error', reject);
            worker.on('exit', (code) => {
                if (code !== 0) {
                    reject(new Error(`Worker Saliendo con codigo = '${code}'`));
                } else {
                    this.logEvent('INFO', `Ejecución Worker Completada Con Exito`, 0);
                    resolve();
                }
            });
        });
    }

    async run(data) {
        try {
            if (!data || data.length < 1) {
                throw new Error('No se recibio data para procesar');
            }
            const workerPromises = data.map((data, index) => this.runWorker({ data, index }));
            const results = await Promise.all(workerPromises);
            return results;
        } catch (e) {
            throw e;
        }
    }

    async execQuery(date1, date2) {
        try {
            if (!date1 || !date2) {
                throw new Error(`Fechas no ingresadas, la query no se puede ejecutar`);
            }
            this.logEvent('INFO', `Ejecutando sp con fechas ${date1}, ${date2}`, 1);
            const request = new sql.Request();
            request.input('beginTime', sql.DateTime, date1);
            request.input('endTime', sql.DateTime, date2);
            const queryE = `EXEC GetConversationDetailsByDate_2 @beginTime , @endTime;`;
            const queryResult = await request.query(queryE);
            if (queryResult.recordset.length < 1) {
                throw new Error('No se encontraron registros');
            }
            this.logEvent('INFO', `Query ejecutado con éxito`, 1);
            return {
                "status": 'OK',
                "data": queryResult
            };
        } catch (e) {
            this.logEvent('ERROR ', `No se logro completar la ejecución del sp ${e}\n${JSON.stringify(e, null, 4)}`, 1);
            return {
                "status": 'ERROR',
                "data": e
            };
        }
    }

    async checkSPinDB() {
        try {
            this.logEvent('INFO', `Verificando existencia de SP en base de datos`, 0);
            if (!this.spLocation) {
                throw new Error('No se ha recibido la ubicación del SP');
            }
            const queryResult = await sql.query('SELECT * FROM sysobjects WHERE xtype = \'P\'');
            this.logEvent('INFO', `Query ejecutado con éxito`, 0);
            const sps = queryResult.recordset;
            const spsNames = sps.map(sp => sp.name);
            if (!spsNames.includes('GetConversationDetailsByDate_2')) {
                this.logEvent('INFO', 'No se encontro el SP en la base de datos', 3);
                this.logEvent('INFO', 'Creando SP en la base de datos', 3);
                const spFile = fs.readFileSync(this.spLocation, 'utf8');
                if (!spFile) {
                    throw new Error('No se logro leer el archivo');
                }
                const request = new sql.Request();
                const createSPResult = await request.query(spFile);
                if (createSPResult.status.toLowerCase() !== 'ok') {
                    throw new Error('No se logro crear el SP');
                }
                this.logEvent('INFO', `SP creado con éxito`, 0);
            }
            this.logEvent('INFO', `SP encontrado con éxito`, 0);
            return {
                "status": 'OK',
                "data": spsNames
            };
        } catch (e) {
            this.logEvent('ERROR ', `No se logro completar la ejecución del sp ${e}\n${JSON.stringify(e, null, 4)}`, 0);
            return {
                "status": 'ERROR',
                "data": e
            };
        }
    }
}

export default ExectSp;

// Configura el cron job para que se ejecute una vez al día a la medianoche
// cron.schedule('0 0 * * *', async () => {
//     const exectSpInstance = new ExectSp();
//     await exectSpInstance.exectSp();
// });