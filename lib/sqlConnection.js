import sql from 'mssql';
import logger from './Logger.js';
import { chargeData } from '../lib/dotenvExtractor.js';
chargeData();
// SQL_PASS,         // 10
// SQL_IP,           // 11
// SQL_PORT,         // 12
// SQL_USER          // 13
class MSSQLConnector {
    constructor( ) {
        this.server = process.argv[11];
        this.user = process.argv[13];
        this.pass = process.argv[10];
        this.dbName = process.argv[5];
        this.connection = null;
    }

    async connect() {
        if (this.connection) {
            return this.connection;
        }

        const sqlWriter = (type, event) => {
            if (type.toLowerCase().includes('error')) {
                logger.error(`[MSSQL_CONNECTOR(${type})]: ${event}`);
                return;
            }
            if (type.toLowerCase().includes('info')) {
                logger.info(`[MSSQL_CONNECTOR(${type})]: ${event}`);
                return;
            }
            if (type.toLowerCase().includes('warn')) {
                logger.warn(`[MSSQL_CONNECTOR(${type})]: ${event}`);
                return;
            } else {
                logger.warn(`[MSSQL_CONNECTOR(${type})]: ${event}\n(Error en tipificación de log)`);
                return;
            }
        };

        if (!this.server || !this.user || !this.pass || !this.dbName) {
            sqlWriter('ERROR', 'Parámetros de conexión inválidos');
            sqlWriter('ERROR', `${this.server} - ${this.user} - ${this.pass} - ${this.dbName}`);
            throw new Error('Invalid connection parameters');
        } else {
            sqlWriter('INFO', 'Parámetros de conexión válidos');
        }

        const config = {
            user: this.user,
            password: this.pass,
            server: this.server,
            database: this.dbName,
            options: {
                encrypt: true, // Use this if you're on Windows Azure
                trustServerCertificate: true // Change to true for local dev / self-signed certs
            }
        };

        try {
            this.connection = await sql.connect(config);
            sqlWriter('INFO', 'Conexión exitosa a Microsoft SQL Server');
            return this.connection;
        } catch (err) {
            sqlWriter('ERROR', `Error al conectar a Microsoft SQL Server: ${err.message}`);
            throw err;
        }
    }

    getConnection() {
        if (!this.connection) {
            throw new Error('Database connection is not established. Call connect() first.');
        }
        return this.connection;
    }
}

export default MSSQLConnector;