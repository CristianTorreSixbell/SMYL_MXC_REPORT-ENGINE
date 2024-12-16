import sql from 'mssql'; 
import  dayjs  from 'dayjs'; 
import { fileURLToPath } from 'url';
import path from 'path';
const __dirname = path.dirname(fileURLToPath(import.meta.url));

class ExtractReportData{
    constructor(){
        this.logEvent = (type, event, submoduleInd) => {
            const submodules = ['MAIN', 'EXTRACT-REPORT-DATA', 'PERIOD-MAKER'];
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
 
    async periodMeaker(){
        try {
            this.logEvent('INFO', 'Calculando periodos..........', 2);

        } catch (e) {
            
        }
    }
 
    async extractReportData(){
       
    const request = new sql.Request();
    const result = await request.query(`
     SELECT TOP   [CASE_ID]
      ,[CONVERSATION_START]
      ,[CONVERSATION_END]
      ,[PARTICIPANT_ID]
      ,[PARTICIPANT_NAME]
      ,[ID_SESSION]
      ,[EMAIL_ADDRESS_FROM]
      ,[EMAIL_ADDRESS_TO]
      ,[QUEUE_INTERACTION_INIT]
      ,[QUEUE_INTERACTION_END]
      ,[TOTAL_HOLD_TIME]
      ,[CLIENT_INTERACTION_INIT]
      ,[CLIENT_INTERACTION_END]
      ,[TOTAL_CLIENT_INTERACTION_TIME]
      ,[AGENT_INTERACTION_INIT]
      ,[AGENT_INTERACTION_END]
      ,[TOTAL_AGENT_INTERACTION_TIME]
      ,[QUEUE_ID]
      ,[QUEUE_NAME]
      ,[SUBJET]
      ,[TRANSFER_CALL]
      ,[CASE_ENDED]
  FROM [insight_smnyl].[dbo].[Historical_Report]
  WHERE [CONVERSATION_START] BETWEEN '${D}' AND '${W}'
 ;`);

 
}

}

export default ExtractReportData;

 
   


 