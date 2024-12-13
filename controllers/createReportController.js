import sql from 'mssql'; 
import  dayjs  from 'dayjs'; 
import { fileURLToPath } from 'url';
import path from 'path';
const __dirname = path.dirname(fileURLToPath(import.meta.url));
import {SQL_USER,    SQL_PASS,    SQL_SERVER,    SQL_DB,    SQL_TIMEOUT } from '../lib/dotenvExtractor.js';
const sqlUser=process.env.SQL_USER
const sqlPassWord=process.env.SQL_PASS
const sqlServer=process.env.SQL_SERVER
const sqlDataBase=process.env.SQL_DB
const sqlTimeOut=process.env.SQL_TIMEOUT 

class ExtractReportData{
    constructor(){
        this.logEvent = (type, event, submoduleInd) => {
            const submodules = ['EXTRACT-SQL-INFO', 'RETURN-PARSED-DATA', 'ENCRYPT-DATA'];
            const moduleName = 'EXTRACT-REPORT-DATA';
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

    async extractReportData(){
        try{

        }catch(e){

        }
    
    }
    async extractSqlInfo(){
        try{
            this.logEvent('INFO', 'Extracting SQL info...', 0);
            
        }catch(e){
            this.logEvent('ERROR', `Error extracting SQL info: ${e.message}`, 0);
        }
    }
    async   connectToSqlDb(){
        try{
        const config = {
            user:sqlUser,
            password: sqlPassWord,
            server: sqlServer,
            options: {
            trustServerCertificate: true 
            },
            database:sqlDataBase, 
            requestTimeout:sqlTimeOut
        };
        const conecction=await sql.connect(config);
        const data = {
            "status":200,
            "data": conecction
        };
        
        return data 
        }catch(e){
        console.log(`[conectToSqlDb(error)]: (No se logro conectar con la base de datos ${e})`)
        const data = {
            "status":500,
            "data": `[conectToSqlDb(error)]: (No se logro conectar con la base de datos ${e})`
        };
        sql.close();
        return data 
        }
    }
    async extractReportData(){
        const connectionResponse= await connectToSqlDb();
    if(connectionResponse.status !== 200 ){
      throw new Error(`No se logro conectar con la base de datos ${connectionResponse.data}`);
    }
    const request = new sql.Request();
    const result = await request.query(`
        SELECT
            mc.mediauid AS mediauid,
            mm.audiofilename AS audiofilename,
            iu.userid AS userid,
            iu.firstname AS firstname,
            iu.lastname AS lastname,
            mcc.ani AS ani,
            mc.starttime AS starttime,
            mc.endtime AS endtime,
            iu.email AS email,
            mc.duration as duration,
            mt.mediadesc as interactiontype,
            mcc.positionid AS station,
            mcc.holdcount AS holdcount,
            q.queueName AS initialworktype,
            mcc.totalholdtime AS totalholdtime,
            mci_disposition.custominfovalue AS dispositioncode,
            mci_description.custominfovalue AS dispositiondescription,
            mci_nuideclientes.custominfovalue AS nuideclientes,
            mci_observacion.custominfovalue AS observacion,
            mci_segmentoclientes.custominfovalue AS segmentoclientes,
            (
                SELECT STRING_AGG(qg.queuegroupname, ', ') WITHIN GROUP (ORDER BY qg.queuegroupname)
                FROM queuegroup qg
                JOIN queuegroup_queue qgq ON qg.queuegroupid = qgq.queuegroupid
                WHERE qgq.queueid = q.queueid
            ) AS skillgroup
        FROM
            dbo.media_core mc
            JOIN dbo.iqmuser AS iu ON mc.userid = iu.userint
            JOIN dbo.mediatype AS mt ON mc.mediatypeid = mt.mediatypeid
            JOIN dbo.media_call AS mcc ON mc.mediaid = mcc.mediaid
            JOIN dbo.media_medium AS mm ON mc.mediaid = mm.mediaid
            JOIN dbo.queue AS q ON mc.initialqueueid = q.queueint
            LEFT JOIN dbo.media_custominfo mci_disposition ON mci_disposition.custominfoid = '74DEAAD1-2293-46A5-81A5-23EEB896CE0F' AND mci_disposition.mediaid = CAST(mc.mediauid AS NVARCHAR(50))
            LEFT JOIN dbo.media_custominfo mci_description ON mci_description.custominfoid = '70B599C8-C0EC-4E81-A93D-95B60B9CDA16' AND mci_description.mediaid = CAST(mc.mediauid AS NVARCHAR(50))
            LEFT JOIN dbo.media_custominfo mci_nuideclientes ON mci_nuideclientes.custominfoid = '1CD95EA8-CC9C-48A1-9BC3-85863151C808' AND mci_nuideclientes.mediaid = CAST(mc.mediauid AS NVARCHAR(50))
            LEFT JOIN dbo.media_custominfo mci_observacion ON mci_observacion.custominfoid = '82A3D8A0-4BBF-450B-9947-C39059C0D1BF' AND mci_observacion.mediaid = CAST(mc.mediauid AS NVARCHAR(50))
            LEFT JOIN dbo.media_custominfo mci_segmentoclientes ON mci_segmentoclientes.custominfoid = '0CA4E9AC-924D-449B-9B9F-599BB98C4E09' AND mci_segmentoclientes.mediaid = CAST(mc.mediauid AS NVARCHAR(50))
        WHERE
            mc.endtime BETWEEN '${beginTime} ${iniHour}'
            AND '${endTime} ${endHour}'
        ;`);

      if(result.recordset.length < 1){
        throw new Error(`No se encontraron datos con la query `);
      }
      const secondList=[]
      const allData=[];
 
}

}

export default ExtractReportData;

 
   


 