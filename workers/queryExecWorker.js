import { workerData, parentPort } from 'worker_threads';
import sql from 'mssql';
import logger from '../lib/Logger.js';
import MSSQLConnector from '../lib/sqlConnection.js';

const sqlConnector = new MSSQLConnector();
await sqlConnector.connect();

const logEvent = (type, event, submoduleInd) => {
    const submodules = [
        'WORKER-RUN',
        'EXEC-QUERYS'
    ];
    const moduleName = 'EXEC_WORKER';
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

const execReq = async (query, retries = 5) => {
    try {
        const request = new sql.Request();
        const result = await request.query(query);
        return result;
    } catch (err) {
        if (retries > 0 && err.name === 'ConnectionError') {
            logEvent('warn', `Retrying query due to connection error: ${err}. Retries left: ${retries}`, 0);
            await new Promise(resolve => setTimeout(resolve, 580)); // Wait 500 ms before retrying
            return execReq(query, retries - 1);
        } else {
            logEvent('error', `Error ejecutando query: ${err}`, 0);
            throw err;
        }
    }
};

async function execQuerys(workerInfo) {
    try {
        logEvent('info', `Inicio de ejecucion de worker ${workerInfo.index}`, 0);
        const row = workerInfo.data;
        let entradaCola = null;
        let salidaCola = null;
        let tiempoTotalCola = null;
        let inicioInteraccionCliente = null;
        let finInteraccionCliente = null;
        let tiempoTotalInteraccionCliente = null;
        let inicioInteraccionAgente = null;
        let finInteraccionAgente = null;
        let tiempoTotalInteraccionAgente = null;
        let queueID = null;
        let queueName = null;
        let subjetc = null;
        let transfer = null;
        let concluido = null;

        if (row.sessionId !== 'NULL' && row.sessionId !== undefined) {
            const [getQueueTime, getClientTime, getAgentTime, getSubjectResult] = await Promise.all([
                execReq(`EXEC GetTiempoCola '${row.sessionId}'`),
                execReq(`EXEC GetTiempoInteraccionCliente '${row.sessionId}'`),
                execReq(`EXEC GetTiempoInteraccionAgente '${row.sessionId}'`),
                execReq(`EXEC GetSubjetBySession '${row.sessionId}'`)
            ]);

            entradaCola = getQueueTime.recordset[0]?.entradaCola || null;
            salidaCola = getQueueTime.recordset[0]?.salidaCola || null;
            tiempoTotalCola = getQueueTime.recordset[0]?.tiempoTotalCola || null;

            inicioInteraccionCliente = getClientTime.recordset[0]?.inicioInteraccionCliente || null;
            finInteraccionCliente = getClientTime.recordset[0]?.finInteraccionCliente || null;
            tiempoTotalInteraccionCliente = getClientTime.recordset[0]?.tiempoTotalInteraccionCliente || null;

            inicioInteraccionAgente = getAgentTime.recordset[0]?.inicioInteraccionAgente || null;
            finInteraccionAgente = getAgentTime.recordset[0]?.finInteraccionAgente || null;
            tiempoTotalInteraccionAgente = getAgentTime.recordset[0]?.tiempoTotalInteraccionAgente || null;

            subjetc = getSubjectResult.recordset[0]?.subject_g || null;
        }

        if (row.conversationId && row.participantId) {
            const getQueueInfoResult = await execReq(`GetQueueInfoByConversation '${row.conversationId}' ,'${row.sessionId}', '${row.participantId}'`);
            queueID = getQueueInfoResult.recordset[0]?.colaId || null;
            queueName = getQueueInfoResult.recordset[0]?.colaName || null;
        }

        if (row.participantId && row.sessionId) {
            const transferOrNotResult = await execReq(`EXEC GetTransferOrNot '${row.participantId}' , '${row.sessionId}';`);
            transfer = transferOrNotResult.recordset[0]?.transfer || null;
            concluido = transferOrNotResult.recordset[0]?.transfer || null;
        }

        const jsonRow = {
            "CASE_ID": row.conversationId === 'NULL' ? " " : row.conversationId,
            "CONVERSATION INIT": row.conversationStart === 'NULL' ? " " : row.conversationStart,
            "CONVERSATION END": row.conversationEnd === 'NULL' ? " " : row.conversationEnd,
            "PARTICIPANT ID": row.participantId === 'NULL' ? " " : row.participantId,
            "PARTICIPANT NAME": row.participantName === 'NULL' ? " " : row.participantName,
            "SESSION ID": row.sessionId === 'NULL' ? " " : row.sessionId,
            "EMAIL ADDRESS FROM": row.addressFrom === 'NULL' ? " " : row.addressFrom,
            "EMAIL ADDRESS TO": row.addressTo === 'NULL' ? " " : row.addressTo,
            "QUEUE ENTRY": entradaCola,
            "QUEUE EXIT": salidaCola,
            "TOTAL QUEUE TIME": tiempoTotalCola,
            "CLIENT INTERACTION INIT": inicioInteraccionCliente,
            "CLIENT INTERACTION END": finInteraccionCliente,
            "TOTAL CLIENT INTERACTION TIME": tiempoTotalInteraccionCliente,
            "AGENT INTERACTION INIT": inicioInteraccionAgente,
            "AGENT INTERACTION END": finInteraccionAgente,
            "TOTAL AGENT TIME SPEND": tiempoTotalInteraccionAgente,
            "QUEUE ID": queueID,
            "QUEUE NAME": queueName,
            "SUBJET": subjetc,
            "TRANSFER": transfer,
            "CONCLUIDO": concluido
        };
        await new Promise(resolve => setTimeout(resolve, 580)); // Wait 500 ms before exiting
        logEvent('info', 'jsonRow = ' + JSON.stringify(jsonRow, null, 4), 0);
        parentPort.postMessage(jsonRow);
        // Wait 500 ms before exiting
        process.exit(0); // Ensure the worker exits after processing
    } catch (error) {
        logEvent('error', `Error en execQuerys: ${error}`, 0);
        parentPort.postMessage(null);
        await new Promise(resolve => setTimeout(resolve, 580)); // Wait 500 ms before exiting
        process.exit(1); // Exit with error code
    }
}

async function workerRun() {
    try {
        const result = await execQuerys(workerData);
        logEvent('info', 'Resultado de la ejecucion: ' + JSON.stringify(result, null, 4), 0);
    } catch (e) {
        logEvent('error', `Error en worker: ${e}`, 0);
    }
}

workerRun();