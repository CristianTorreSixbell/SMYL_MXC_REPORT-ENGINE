import mongoose from 'mongoose';
import logger from './Logger.js';

class MongoDBConnector {
    constructor({ url, user, pass, dbName }) {
        this.url = url;
        this.user = user;
        this.pass = pass;
        this.dbName = dbName;
        this.connection = null;
    }

    async connect() {
        if (this.connection) {
            return this.connection;
        }

        const mongoWriter = (type, event) => {
            if (type.toLowerCase().includes('error')) {
                logger.error(`[MONGO_CONNECTOR(${type})]: ${event}`);
                return;
            }
            if (type.toLowerCase().includes('info')) {
                logger.info(`[MONGO_CONNECTOR(${type})]: ${event}`);
                return;
            }
            if (type.toLowerCase().includes('warn')) {
                logger.warn(`[MONGO_CONNECTOR(${type})]: ${event}`);
                return;
            } else {
                logger.warn(`[MONGO_CONNECTOR(${type})]: ${event}\n(Error en tipificación de log)`);
                return;
            }
        };

        if (!this.url || !this.user || !this.pass || !this.dbName) {
            mongoWriter('ERROR', 'Parámetros de conexión inválidos');
            throw new Error('Invalid connection parameters');
        } else {
            mongoWriter('INFO', 'Parámetros de conexión válidos');
        }

        const dbUri = this.url;

        try {
            await mongoose.connect(dbUri, {
                auth: {
                    username: this.user,
                    password: this.pass
                },
                dbName: this.dbName
            });
            mongoWriter('INFO', 'Conexión exitosa a MongoDB');
            this.connection = mongoose.connection;
            this.connection.on('error', (error) => {
                mongoWriter('ERROR', `Error de conexión a MongoDB: ${error.message}`);
            });
            this.connection.once('open', () => {
                mongoWriter('INFO', 'Conexión inicializada a MongoDB');
            });
            return this.connection;
        } catch (err) {
            mongoWriter('ERROR', `Error al conectar a MongoDB: ${err.message}`);
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

export default MongoDBConnector;