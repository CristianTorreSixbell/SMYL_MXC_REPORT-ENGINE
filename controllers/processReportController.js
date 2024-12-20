import { fileURLToPath } from 'url';
import path from 'path';
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
    }

    async extractInterval(req, res) {
        try {
            this.logEvent('INFO', 'Extrayendo intervalo..........', 0);
            const intervalSearch = await this.periodMaker();
            if (intervalSearch.status !== 'Ok') {
                throw new Error(`No se pudo extraer el intervalo ${intervalSearch.data}`);
            }
            const intervalArr = intervalSearch.data;
            for (const interval of intervalArr) {
                this.logEvent('INFO', `Procesando Fecha: ${interval}`, 0);
            }
            return res.status(200).send("ok");
        } catch (e) {
            this.logEvent('ERROR', `No se logró extraer el intervalo desde la base datos ${e},\n${JSON.stringify(e, null, 4)}`, 1);
            return res.status(500).send("error");
        }
    }

    async periodMaker() {
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
                    intervalArr.push(element.datesTFind);
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
    async updateReport(id,state){
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
            }
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
 