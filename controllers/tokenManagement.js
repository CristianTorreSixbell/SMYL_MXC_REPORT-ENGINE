 







class TokenManagement{
    constructor(){
        this.logEvent = (type, event, submoduleInd) => {
            const submodules = ['CREATE-DIVISION-IN-GENESYS', 'GET-DIVISION-NAMES', 'POST-DIVISIONS'];
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

    async verifyToken(req, res){
        try{

        }catch(e){

        }
    }
    

    async getToken(req, res){
        try{

        }catch(e){

        }
    }


    async createToken(req, res){
        try{ 

        }catch(e){

        }
    }


}

export default TokenManagement;