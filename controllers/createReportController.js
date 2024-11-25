

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

}
export default ExtractReportData;