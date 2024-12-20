import log4js from "log4js";
import path from 'path';
import dayjs from 'dayjs';
import timezone from 'dayjs/plugin/timezone.js';
import utc from 'dayjs/plugin/utc.js';

dayjs.extend(utc);
dayjs.extend(timezone);
dayjs.tz.setDefault('America/Mexico_City'); // Asegúrate de usar la zona horaria correcta

const loggerName = "ReportEngine";

// Función para obtener el timestamp personalizado
const getCustomTimestamp = () => {
    return dayjs().tz('America/Mexico_City').format("YYYY-MM-DDTHH:mm:ss.SSSZ");
};

log4js.configure({
    appenders: {
        out: {
            type: 'stdout',
            layout: {
                type: 'pattern',
                pattern: '%[%d %p [%f{1}:%l]%] %X{customTimestamp} %m',
                tokens: {
                    user: function (logEvent) {
                        return AuthLibrary.currentUser();
                    },
                    customTimestamp: function () {
                        return getCustomTimestamp();
                    }
                }
            }
        },
        file: {
            type: 'file',
            layout: {
                type: 'pattern',
                pattern: '%[%d %p [%f{1}:%l]%] %X{customTimestamp} %m',
                tokens: {
                    user: function (logEvent) {
                        return AuthLibrary.currentUser();
                    },
                    customTimestamp: function () {
                        return getCustomTimestamp();
                    }
                }
            },
            mode: 0o644,
            maxLogSize: 31457280,
            backups: 100,
            pattern: "yyyy-MM-dd.log",
            filename: path.join('/tmp/datareport', 'log', 'BulkUserStats')
        }
    },
    categories: {
        debug: { enableCallStack: true, appenders: ['out', 'file'], "level": "debug" },
        default: { enableCallStack: true, appenders: ['out', 'file'], "level": "info" },
        error: { enableCallStack: true, appenders: ['out', 'file'], "level": "error" },
        warn: { enableCallStack: true, appenders: ['out', 'file'], "level": "warn" }
    }
});

const logger = log4js.getLogger(loggerName);

logger.level = "info";

logger.addContext("custom", '');

export default logger;