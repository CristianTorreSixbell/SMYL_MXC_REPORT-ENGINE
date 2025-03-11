import axios from 'axios';
import cron from 'node-cron';
  
import {chargeData} from '../lib/dotenvExtractor.js';
chargeData();

class Executor {
    constructor() {
        this.cronSchedule = process.argv[15] || null;
        this.endpointUrl =  process.argv[18] || null;
        this.selfURI= process.argv[16] || null;
        this.port=process.argv[7] || null ;

        if (!this.cronSchedule || !this.endpointUrl) {
            throw new Error('Parametros invalidos Exec time, urlsp ');
        }
    }

    async executeEndpoint() {
        try {
            const uri=`${this.selfURI}:${this.port}${this.endpointUrl}`;
            const response = await axios.get(uri);
            console.log(`Sp Executado Correctamente: ${response.status} - ${response.data}`);
        } catch (error) {
            console.error(`Error al Executar el SP: ${error.message} `+this.selfURI+':'+this.port+this.endpointUrl);
        }
    }

    start() {
        cron.schedule(this.cronSchedule, () => {
            console.log(`Executing endpoint at ${new Date().toISOString()}`);
            this.executeEndpoint();
        });
        console.log(`Orchestrator started with schedule: ${this.cronSchedule}`);
    }
}

export default Executor;

const newExecutor=new Executor();
const result=newExecutor.start();
console.log(result)