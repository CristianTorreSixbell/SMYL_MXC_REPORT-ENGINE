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

import { chargeData } from '../lib/dotenvExtractor.js';
import historicalModel from '../models/rawSqlData.js';
import reportModel from '../models/reportModel.js';

chargeData();

dayjs.extend(utc);
dayjs.extend(timezone);
dayjs.tz.setDefault('America/Chicago');
const fechaMexico = dayjs().subtract(6, 'hours').format("YYYY-MM-DDTHH:mm:ss.SSSZ");
const __dirname = path.dirname(fileURLToPath(import.meta.url)); // Path actual


const generateUniqueId = (length = 32) => {
    return crypto.randomBytes(length).toString('hex');
};

// Ejemplo de uso


class ExectSp {
    constructor() {
        this.logEvent = (type, event, submoduleInd) => {
            const submodules = ['MAIN','EXEC-QUERY','GET-DATES','VERIFY-SP'];
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
        this.getDates = this.getDates.bind(this);
        this.execQuery= this.execQuery.bind(this);
        this.uniqueId = generateUniqueId();
        this.checkSPinDB= this.checkSPinDB.bind(this);
        this.spLocation=path.join(__dirname,'../static/sql-obj/sp2.sql');
    }
    getDates(day) {
        try {
            const intervalArr=[];
            for(let i  =0 ; i < 23;i++){
                const hour=`${day} ${i >= 10  ? i : '0'+i }:00:00/ ${day} ${i >= 10  ? i+1 : parseInt(i+1 >= 10 ? parseInt(i+1) : `0${parseInt(i+1)}`) }:59:59`;
                intervalArr.push(`${hour}`);
            }
            this.logEvent('info', `Day parsed: ${intervalArr}`,2);
            return intervalArr;
        }catch (error) {
            this.logEvent('error', `Error parsing day: ${error}\n${JSON.stringify(error,null,4)}`, 2);
            return [];
        }
    }// Creacion periodo de busqueda cada dos horas aprox

    async exectSp(req,res,trys=0){ // Funcion principal, alimentando data historica
        try{
            const maxtry= 4;
            cron.schedule(process.argv[15] , async () => {
                trys+1;
                const spCheckResult=await this.checkSPinDB();
                if(spCheckResult.status.toLocaleUpperCase() !== 'OK'){
                    throw new Error('No se logro verificar la existencia del SP');
                }// verificamos si el SP existe en la base de datos y si no lo creamos
                const day=dayjs(fechaMexico).add(6, 'hours')/*Paso a UTC*/.subtract(1, 'day')/*DIA -1*/.format("YYYY-MM-DD  HH:mm:ss");
                const datesToSeach=this.getDates(day);// Armado de peridos de busqueda
                if(datesToSeach.length < 1){
                    throw new Error('No se logro armar los periodos de busqueda');
                }
                const allDayData=[];
                for(const date of datesToSeach){// Recorrer periodos
                    const dateArr=date.split('/');
                    const query = `EXEC GetConversationDetailsByDate '${dateArr[0]}', '${dateArr[1]}'`;// Busqueda periodo por hora T = 24 seg * periodo
                    const queryRes=await this.execQuery(query);
                    if(queryRes.recodset.lenght < 1){
                        throw new Error('No se encontraron registros');
                    }
                    const data=queryRes.recordset;
                    for(const row of data){ // Recorrer data
                        const jsonRow = {
                            "CASE_ID":row.conversationId = 'NULL' ? " ":conversationId,
                            "CONVERSATION INIT":row.conversationStart = 'NULL' ? " ":conversationStart,
                            "CONVERSATION END":row.conversationEnd = 'NULL' ? " ":conversationEnd,
                            "PARTICIPANT ID":row.participantId = 'NULL' ? " ":participantId,
                            "PARTICIPANT NAME":row.participantName = 'NULL' ? " ":participantName,
                            "SESSION ID":row.sessionId = 'NULL' ? " ":sessionId,
                            "EMAIL ADDRESS FROM":row.addressFrom = 'NULL' ? " ":addressFrom,
                            "EMAIL ADDRESS TO":row.addressTo = 'NULL' ? " ":addressTo,
                            "QUEUE ENTRY":row.entradaCola = 'NULL' ? " ":entradaCola,
                            "QUEUE EXIT":row.salidaCola = 'NULL' ? " ":salidaCola,
                            "TOTAL QUEUE TIME":row.tiempoEnCola = 'NULL' ? " ":tiempoEnCola,
                            "CLIENT INTERACTION INIT":row.inicioInteraccionCliente = 'NULL' ? " ":inicioInteraccionCliente,
                            "CLIENT INTERACTION END	":row.finInteraccionCliente = 'NULL' ? " ":finInteraccionCliente,
                            "TOTAL CLIENT INTERACTION TIME":row.tiempoTotalInteraccionCliente = 'NULL' ? " ":tiempoTotalInteraccionCliente,
                            "AGENT ITERACTION INIT":row.inicioInteraccionAgente = 'NULL' ? " ":inicioInteraccionAgente,
                            "AGENT INTERACTION END":row.finInteraccionAgente = 'NULL' ? " ":finInteraccionAgente,
                            "TOTAL AGENT TIME SPEND":row.tiempoInteraccionAgente = 'NULL' ? " ":tiempoInteraccionAgente,
                            "QUEUE ID":row.colaId = 'NULL' ? " ":colaId,
                            "QUEUE NAME":row.colaNombre = 'NULL' ? " ":colaNombre,
                            "SUBJET":row.subject_g = 'NULL' ? " ":subject_g,
                            "TRANSFER":row.transferido = 'NULL' ? " ":transferido,
                            "CONCLUIDO":row.concluido = 'NULL' ? " " : concluido
                        } // Extracción de data
                        allDayData.push(jsonRow);// extraccion de data y parseo para almacenamiento en coleccion historica
                    }
                }
                const newHistoricalData= new historicalModel({
                    "searchingPeriod":  `${day}/${dayjs(day).add(1, 'day').format("YYYY-MM-DD  HH:mm:ss")}`,
                    "clientReporData":  allDayData
                }); // Creación de objeto para almacenamiento en coleccion historica
                
                const saveResult=newHistoricalData.save(day);
                if(saveResult.lenght < 1 || saveResult === undefined){ // Verificación de guardado
                    throw new Error('No se logro guardar la data');                  
                }
                this.logEvent('INFO',`Data guardada con éxito`,0); // Log de guardado
                const reportSchema = new reportModel({
                    "datesTFind":  `${day}/${dayjs(day).add(1, 'day').format("YYYY-MM-DD  HH:mm:ss")}`,
                    "dateProcess":  new Date(fechaMexico).toISOString(),
                    "reportId":  uniqueId,
                    "state":  "ready-to",
                    "result": "Data saved in transitory collection" 
                });
                const saveReportResult=reportSchema.save();
                if(saveReportResult.lenght < 1 || saveReportResult === undefined){
                    throw new Error('No se logro guardar el reporte');

                }
                return res.status(200).send("Información procesada con éxito");
            });
        }catch(e){
            this.logEvent('ERROR ',`No se logro completar la ejecución del sp ${e}\n${JSON.stringify(e,null,4)}` , 0);
            if(trys < maxtry){
                this.logEvent('INFO',`Reintentando ejecución ${trys}`,0);
                return this.exectSp(req,res,trys); // Reintentar ejecución
            }
            return res.status(500).send(  'EXEC Error '+e );

        }

    }

    async execQuery(query){
        try {
            this.logEvent('INFO',`Ejecutando query ${query}`,1);
            const queryResult = await sql.query(query);
            this.logEvent('INFO',`Query ejecutado con éxito`,1);
            
            return{
                "status":'OK',
                "data":  queryResult
            }
        } catch (e) {
            this.logEvent('ERROR ',`No se logro completar la ejecución del sp ${e}\n${JSON.stringify(e,null,4)}` , 1);
            return {
                "status":'ERROR',
                "data":  e
            };
        }
    }// Ejecución de querys
    async checkSPinDB(){
        try {
            
            this.logEvent('INFO',`Verificando existencia de SP en base de datos`,0);
            if( ! this.spLocation || this.spLocation === undefined){
                throw new Error('No se ha recibido la ubicación del SP');
            }
            const queryResult = await sql.query('SELECT * FROM sysobjects WHERE xtype = \'P\'');
            this.logEvent('INFO',`Query ejecutado con éxito`,0);
            const sps=queryResult.recordset;
            const spsNames=[];
            for(const sp of sps){
                spsNames.push(sp.name);
            }
            if(!spsNames.includes('GetConversationDetailsByDate')){
                this.logEvent('INFO','No se encontro el SP en la base de datos',3);
                this.logEvent('INFO','Creando SP en la base de datos',3);
                const spFile=fs.readFileSync(this.spLocation,'utf8');
                if(spFile.lenght < 1 || spFile === undefined){
                    throw new Error('No se logro leer el archivo');
                }
                const createSPResult=await this.execQuery(spFile);
                if(createSPResult.status.toLowerCase() != 'ok'){
                    throw new Error('No se logro crear el SP');
                }
                this.logEvent('INFO',`SP creado con éxito`,0);
                
            }
            this.logEvent('INFO',`SP encontrado con éxito`,0);
            return{
                "status":'OK',
                "data":  spsNames
            }
        }catch(e){
            this.logEvent('ERROR ',`No se logro completar la ejecución del sp ${e}\n${JSON.stringify(e,null,4)}` , 0);
            return {
                "status":'ERROR',
                "data":  e
            };
        }
    }
}

export default ExectSp;
const newExectSpClassObjt = new ExectSp();
const executor = newExectSpClassObjt.exectSp;
await executor();// Ejecución de la tarea programada