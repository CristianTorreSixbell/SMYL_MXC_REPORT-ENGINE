
import logger from '../lib/Logger.js'; 




class Test{
    constructor() {
        this.logEvent = (type, event, submoduleInd) => {
            const submodules = ['MAIN'];
            const moduleName = 'TEST';
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



}
const newDayParser = new Test();
const dayArray = newDayParser  ;
console.log(JSON.stringify(dayArray,null,4))

