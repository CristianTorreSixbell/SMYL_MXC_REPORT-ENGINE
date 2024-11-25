




class FileCreator{
    constructor(key){
        this.logEvent = (type, event, submoduleInd) => {
            const submodules = ['CREATE-FILE', 'GET-DIVISION-NAMES', 'POST-DIVISIONS'];
            const moduleName = 'CREATE_DIVISION';
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
    async createFile(req, res){
        try{

        }catch(e){

        }
    }
    async descryptFile(req, res){
        try{

        }catch(e){  
        }
    }
}

export default FileCreator;