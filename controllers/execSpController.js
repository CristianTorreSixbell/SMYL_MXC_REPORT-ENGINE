import sql from 'mssql'; 
import { chargeData } from '../lib/dotenvExtractor';
import cron from 'node-cron';
import logger from '../lib/Logger.js';
import dayjs from 'dayjs';
import timezone  from 'dayjs/plugin/timezone.js'; 
dayjs.extend(utc);
dayjs.extend(timezone);
dayjs.tz.setDefault('America/Chicago');
         
const fechaMexico = dayjs().subtract(6,'hours').format("YYYY-MM-DDTHH:mm:ss.SSSZ");
chargeData();

class ExectSp{
    constructor(){
        this.logEvent = (type, event, submoduleInd) => {
            const submodules = ['MAIN'];
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
    }

    async exectSp(req,res){
        try {
            cron.schedule( process.argv[15], async () => {            
                try{
                    this.logEvent('INFO', 'Ejecutando SP', 0);
                    const request = new sql.Request();
                    const dateToInyect1=dayjs(fechaMexico).add(6,'hours').subtract(1,'day').format("YYYY-MM-DD HH:mm:ss");// día actual -1
                    const dateToInyect2=dayjs(fechaMexico).add(6,'hours').subtract(2,'day').format("YYYY-MM-DD HH:mm:ss");// día actual -2
                    this.logEvent('INFO', `Fecha actual(UTC-6): ${fechaMexico} `, 0);
                    this.logEvent('INFO', `Ejecutando SP con fechas(UTC): ${dateToInyect1} y ${dateToInyect2}`, 0);    
                    const result = await request.query(`EXEC GetConversationDetailsByDate '${dateToInyect1}', '${dateToInyect2}';`);//'YYYY-MM-DD HH:MM:SS', 'YYYY-MM-DD HH:MM:DD';`);
                    if(result.recordset.length < 1){
                        throw new Error(`No se encontraron datos con la query `);
                    }
                    this.logEvent('INFO', `SP ejecutado con éxito, datos cargados en tabla exitosamente`, 0);
                    const rowsQuantity= result.recordset.length;
                    return {
                        "status": 200,
                        "message": `SP ejecutado con éxito, datos cargados en tabla exitosamente, ${rowsQuantity} filas insertadas`,
                    }
                }catch(e){
                    throw Error
                }
            });
        } catch (e) {
            this.logEvent('ERROR', `Error al ejecutar SP ${e}\n${JSON.stringify(e,null,4)}` , 0);    
            return{
                "status": 500,
                "message": `Error al ejecutar SP ${e}\n${JSON.stringify(e,null,4)}`,
            }
        }
    }
}

const newExectSpClassObjt= new ExectSp;
const executor = newExectSpClassObjt.exectSp;
await executor();