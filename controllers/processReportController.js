import { fileURLToPath } from 'url';
import path from 'path';
import axios from 'axios';

import logger from '../lib/Logger.js';
import reportModel from '../models/reportModel.js';
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
            await wait(ms);  
            console.log('5 minutos han pasado.');
        };
        
    }

    async extractInterval(req, res ) { // Funcion principal
        try {
            const maxRtry=4;
            let trys=0;
            this.logEvent('INFO', 'Extrayendo intervalo..........', 0);
            const intervalSearch = await this.periodMaker();
            if (intervalSearch.status !== 'Ok') {
                throw new Error(`No se pudo extraer el intervalo ${intervalSearch.data}`);
            }
            const intervalArr = intervalSearch.data;
            const errorInterval= [];
            for (const intervalObj of intervalArr) {
                this.logEvent('INFO', `Procesando Fecha: ${intervalObj.interval}`, 0);
                // Creando reportes periodo por periodo.                
                const reqBody={
                    "interval": intervalObj.interval,
                    "reportID":intervalObj.reportID
                };
                const port=process.argv[7];
                const host=process.argv[16];
                const endpoint=process.argv[17];
                const updateProcessingReport=await this.updateReport(intervalObj.reportID,'in-progress');
                if(updateProcessingReport.status==='Error'){
                    this.logEvent('ERROR', `No se logró actualizar el reporte ${updateProcessingReport.data}`, 1);
                    errorInterval.push(intervalObj);
                    continue;
                }
                const response = await axios.post(`${host}:${port}${endpoint}` , reqBody);

                if(response.status!==200){
                    this.logEvent('ERROR', `No se logró Crear el reporte de intervalo ${intervalObj.interval} ${response.data}`, 1);
                    errorInterval.push(intervalObj);
                    continue;
                }
                const updateDReport=await this.updateReport(intervalObj.reportID,'done');
                if(updateDReport.status==='Error'){
                    this.logEvent('ERROR', `No se logró actualizar el reporte ${updateDReport.data}`, 1);
                    errorInterval.push(intervalObj);
                    continue;
                }
                this.logEvent('INFO', `Reporte procesado ${intervalObj.interval}`, 0);
            }
            if(errorInterval.length > 0){ // Reprocesando intervalos con error
                this.logEvent('ERROR', `Reprocesando intervalos`, 1);
                while (trys < maxRtry && errorInterval.length > 0) {
                    trys++;
                    const newErrorInterval = [];
                    for (const intervalObj of errorInterval) {
                        this.logEvent('INFO', `Reintentando Fecha: ${intervalObj.interval}`, 0);
                        // Creando reportes periodo por periodo.                
                        const reqBody = {
                            "interval": intervalObj.interval,
                            "reportID": intervalObj.reportID
                        };
                        const port = process.argv[7];
                        const host = process.argv[16];
                        const endpoint = process.argv[17];
                        const updateProcessingReport = await this.updateReport(intervalObj.reportID, 'in-progress');
                        if (updateProcessingReport.status === 'Error') {
                            this.logEvent('ERROR', `Retry: No se logró actualizar el reporte ${updateProcessingReport.data}`, 1);
                            newErrorInterval.push(intervalObj);
                            continue;
                        }
                        const response = await axios.post(`${host}:${port}${endpoint}`, reqBody);
                
                        if (response.status !== 200) {
                            this.logEvent('ERROR', `Retry: No se logró extraer el intervalo ${response.data}`, 1);
                            newErrorInterval.push(intervalObj);
                            continue;
                        }
                        const updateDReport = await this.updateReport(intervalObj.reportID, 'done');
                        if (updateDReport.status === 'Error') {
                            this.logEvent('ERROR', `Retry: No se logró actualizar el reporte ${updateDReport.data}`, 1);
                            newErrorInterval.push(intervalObj);
                            continue;
                        }
                        this.logEvent('INFO', `Reporte procesado ${intervalObj.interval}`, 0);
                    }
                    // Actualizar errorInterval con los elementos que fallaron
                    errorInterval = newErrorInterval;
                    // Esperar 5 minutos antes de reintentar
                    await this.wait(300000); // 300,000 milisegundos = 5 minutos
                }
            }

            return res.status(200).json({"Msg":"Proceso finalizado con exito"});
        } catch (e) {
            this.logEvent('ERROR', `No se logró extraer el intervalo desde la base datos ${e},\n${JSON.stringify(e, null, 4)}`, 1);
            return res.status(500).json({"Msg":""});
        }
    }

    async periodMaker() {// Creación Periodos
        try {
            this.logEvent('INFO', 'Calculando periodos..........', 1);
            const intervalArr = [];
            const intervalSearch = await reportModel.find({});
            if (!intervalSearch || intervalSearch.length === 0) {
                this.logEvent('INFO', 'No hay periodos pendientes', 1);
            } else if (intervalSearch.length === 1) {
                this.logEvent('INFO', 'Existe un periodo pendiente', 1);
                intervalArr.push(intervalSearch[0].datesTFind); // dates format YYYY-MM-DD HH:MM:SS/YYYY-MM-DD HH:MM:SS
            } else if (intervalSearch.length > 1) {
                this.logEvent('INFO', 'Existe más de un periodo pendiente', 1);
                intervalSearch.forEach((element) => {
                    intervalArr.push({
                        "interval":    element.datesTFind,
                        "reportID":     element.reportId
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
    
    async updateReport(id,state){ // Actualiza estado de reporte
        try {
            this.logEvent('INFO', 'Actualizando reporte..........', 3);
            if(!id||!state){
                throw new Error('No se ha recibido el id/estado del reporte');
            }
            let updateState='';
            switch(state){
              case state.toString().toLowerCase().includes('in-progress'):
                    updateState='in-progress';
                    break;
              case state.toString().toLowerCase().includes('done'):
                    updateState='done';
                    break;
              case state.toString().toLowerCase().includes('start'):
                    updateState='start';
                    break;
              default:
                    throw new Error('Estado no reconocido');
            };
            const updateResult = await reportModel.findOneAndUpdate(
                {reportId:id},
                {$set:{
                    status: updateState,
                }},
                { new: true, upsert: true }
            );
            if(updateResult.length===0 || !updateResult){
                throw new Error('No se ha actualizado el stado del reporte');
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
            
            }
        }
    } 
}

export default ProcessReport;
 