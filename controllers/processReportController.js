import { fileURLToPath } from 'url';
import path from 'path';
import axios from 'axios';

import logger from '../lib/Logger.js';
import reportModel from '../models/reportModel.js';
import historicalModel from '../models/rawSqlData.js';
import { chargeData } from '../lib/dotenvExtractor.js';
chargeData();
const __dirname = path.dirname(fileURLToPath(import.meta.url));

class ProcessReport {
    constructor() {
        this.logEvent = (type, event, moduleIndex) => {
            const modules = ['MAIN', 'PERIOD-MAKER', 'EXTRACT-INTERVAL','UPDATE-REPORT'];
            const className = 'PROCESS-REPORT';
            const module = parseInt(moduleIndex) ? `][${modules[parseInt(moduleIndex)]}` : '';
            if (type.toLowerCase().includes('error')) {
                logger.error(`[${className}${module}(${type})]: ${event}`);
                return;
            }
            if (type.toLowerCase().includes('info')) {
                logger.info(`[${className}${module}(${type})]: ${event}`);
                return;
            }
            if (type.toLowerCase().includes('warn')) {
                logger.warn(`[${className}${module}(${type})]: ${event}`);
                return;
            } else {
                logger.warn(`[${className}${module}(${type})]: ${event}\n(Error en tipificación de log)`);
                return;
            }
        };
        this.periodMaker = this.periodMaker.bind(this);
        this.extractInterval = this.extractInterval.bind(this);
        this.wait = (ms) => {
            return new Promise(resolve => setTimeout(resolve, ms));
        };
        this.waitNTime = async (ms) => {
            console.log('Esperando 5 minutos...');
            await this.wait(ms);  
            console.log('5 minutos han pasado.');
        };
    }

    async extractInterval(req, res) { // Funcion principal
        try {
            const maxRtry = 4;
            let trys = 0;
            
            this.logEvent('INFO', 'Extrayendo intervalo..........', 0);
            const intervalSearch = await this.periodMaker();
            if (intervalSearch.status !== 'Ok') {
                throw new Error(`No se pudo extraer el intervalo ${intervalSearch.data}`);
            }
            const intervalArr = intervalSearch.data;
            const errorInterval = [];
            for (const intervalObj of intervalArr) {
                this.logEvent('INFO', `Procesando Fecha: ${intervalObj.interval}`, 0);
                console.log(intervalObj);
                // Creando reportes periodo por periodo.                
                const reqBody = {
                    "interval": intervalObj.interval,
                    "reportID": intervalObj.reportID
                };
                const port = process.argv[7];
                const host = process.argv[16];
                const endpoint = process.argv[17];
                const updateProcessingReport = await this.updateReport(intervalObj.reportID, 'in-progress', 'Generation in progress');
                if (updateProcessingReport.status === 'Error') {
                    this.logEvent('ERROR', `No se logró actualizar el reporte ${updateProcessingReport.data}`, 1);
                    errorInterval.push(intervalObj);
                    continue;
                }
                const response = await axios.post(`${host}:${port}${endpoint}`, reqBody);

                if (response.status !== 200) {
                    const updateErrorReport = await this.updateReport(intervalObj.reportID, 'error', `Generation Error: ${response.data}`);
                    if (updateErrorReport.status === 'Error') {
                        this.logEvent('ERROR', `No se logró actualizar el reporte ${updateErrorReport.data}`, 1);
                    }
                    this.logEvent('ERROR', `No se logró Crear el reporte de intervalo ${intervalObj.interval} ${response.data}`, 1);
                    errorInterval.push(intervalObj);
                    continue;
                }
                const updateDReport = await this.updateReport(intervalObj.reportID, 'done', 'Report generation process complete successfully');
                if (updateDReport.status === 'Error') {
                    this.logEvent('ERROR', `No se logró actualizar el reporte ${updateDReport.data}`, 1);
                    errorInterval.push(intervalObj);
                    continue;
                }
                this.logEvent('INFO', `Reporte procesado ${intervalObj.interval}`, 0);
            }

            return res.status(200).json({"Msg":"Proceso finalizado con exito"});
        } catch (e) {
            this.logEvent('ERROR', `No se logró extraer el intervalo desde la base datos ${e},\n${JSON.stringify(e, null, 4)}`, 1);
            return res.status(500).json({"Msg":""});
        }
    }

    async periodMaker() { // Creación Periodos
        try {
            this.logEvent('INFO', 'Calculando periodos..........', 1);
            const intervalArr = [];
            const intervalSearch = await reportModel.find({ state: { $ne: 'done' } });
            if (!intervalSearch || intervalSearch.length === 0) {
                this.logEvent('INFO', 'No hay periodos pendientes', 1);
            } else {
                this.logEvent('INFO', `Existen ${intervalSearch.length} periodos pendientes`, 1);
                intervalSearch.forEach((element) => {
                    intervalArr.push({
                        "interval": element.datesTFind,
                        "reportID": element.reportId
                    });
                });
            }
            this.logEvent('INFO', 'Periodos calculados', 1);
            return {
                status: 'Ok',
                data: intervalArr
            };
        } catch (e) {
            this.logEvent('ERROR', `No se logró extraer el intervalo desde la base datos ${e},\n${JSON.stringify(e, null, 4)}`, 1);
            return {
                status: 'Error',
                data: e
            };
        }
    }
    
    async updateReport(id, state, result) { // Actualiza estado de reporte
        try {
            this.logEvent('INFO', 'Actualizando reporte..........', 3);
            if (!id || !state || !result) {
                throw new Error('No se ha recibido el id/estado/result del reporte');
            }
            let updateState = '';
            switch (true) {
                case state.toString().toLowerCase().includes('in-progress'):
                    updateState = 'in-progress';
                    break;
                case state.toString().toLowerCase().includes('done'):
                    updateState = 'done';
                    break;
                case state.toString().toLowerCase().includes('start'):
                    updateState = 'start';
                    break;
                case state.toString().toLowerCase().includes('error'):
                    updateState = 'error';
                    break;
                default:
                    throw new Error('Estado no reconocido');
            }
            const updateResult = await reportModel.findOneAndUpdate(
                {"reportId": id},
                {$set: {
                    state: updateState,
                    result: result
                }},
                { new: true, upsert: true }
            );
            if (!updateResult) {
                throw new Error('No se ha actualizado el estado del reporte');
            }
            this.logEvent('INFO', 'Reporte actualizado', 3);
            return {
                status: 'Ok',
                data: updateResult
            };
        } catch (error) {   
            this.logEvent('ERROR', `No se logró actualizar el reporte ${error},\n${JSON.stringify(error, null, 4)}`, 3);
            return {
                status: 'Error',
                data: error
            };
        }
    } 
}

export default ProcessReport;