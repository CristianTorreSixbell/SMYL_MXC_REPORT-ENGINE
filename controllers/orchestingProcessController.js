import { chargeData } from "../lib/dotenvExtractor.js";
import cron from 'node-cron';
import axios from 'axios';

chargeData();

class OrchestProcess {
    constructor() {
        this.logEvent = this.logEvent.bind(this);
        this.orchestProcess = this.orchestProcess.bind(this);
        this.encryptionKey = process.argv[6] || null;
        if (this.encryptionKey.length !== 32) {
            throw new Error('Invalid encryption key length. Key must be 32 bytes.');
        }

        // Configurar los cron jobs
        this.setupCronJobs();
    }

    logEvent(type, event) {
        // Implementación de logEvent
    }

    async orchestProcess() {
        // Implementación de orchestProcess
    }

    setupCronJobs() {
        // Cron job para ejecutar el SP todos los días a las 0 am
        cron.schedule('0 0 * * *', async () => {
            try {
                SELF_URL,         // 16  
                CREATION_ENDPOINT,// 17   
                SP_ENDPOINT,      // 18
                this.logEvent('INFO', 'Ejecutando cron job para exectSP');
                const response = await axios.post(`http://localhost:443/exectSP`);
                this.logEvent('INFO', `Respuesta de exectSP: ${response.data}`);
            } catch (error) {
                this.logEvent('ERROR', `Error en cron job para exectSP: ${error.message}`);
            }
        });

        // Cron job para generar el reporte todos los días a las 13 pm
        cron.schedule('0 13 * * *', async () => {
            try {
                this.logEvent('INFO', 'Ejecutando cron job para generateReport');
                const response = await axios.post('http://localhost:443/generateReport');
                this.logEvent('INFO', `Respuesta de generateReport: ${response.data}`);
            } catch (error) {
                this.logEvent('ERROR', `Error en cron job para generateReport: ${error.message}`);
            }
        });
    }
}

export default OrchestProcess;