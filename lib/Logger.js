import log4js from "log4js";
import path   from 'path';
import dayjs from 'dayjs';
import timezone  from 'dayjs/plugin/timezone.js'; 

dayjs.extend(utc);
dayjs.extend(timezone);
dayjs.tz.setDefault('America/Chicago');
chargeData();         
const fechaMexico = dayjs().subtract(6,'hours').format("YYYY-MM-DDTHH:mm:ss.SSSZ");
var loggerName = "ReportEngine";

//cambiar por luxon

log4js.configure( {
	appenders : {
		out : {
			type  : 'stdout',
			layout: {
				type   : 'pattern',
				pattern: '%[%d %p [%f{1}:%l]%] %X{custom} %m',
				tokens : {
					user: function ( logEvent )
					{
						return AuthLibrary.currentUser();
					}
				}
			}
		},
		file: {
			type      : 'file',
			layout    : {
				type   : 'pattern',
				pattern: '%[%d %p [%f{1}:%l]%] %X{custom} %m',
				tokens : {
					user: function ( logEvent )
					{
						return AuthLibrary.currentUser();
					}
				}
			},
			mode      : 0o644,
			maxLogSize: 31457280,
			backups   : 100,
			pattern   : "yyyy-MM-dd.log",
			filename  : path.join( '/tmp/datareport', 'log', 'BulkUserStats' )		
		}
	},
	categories: {
		debug  : { enableCallStack: true, appenders: [ 'out', 'file' ], "level": "debug" },
		default: { enableCallStack: true, appenders: [ 'out', 'file' ], "level": "info" },
		error  : { enableCallStack: true, appenders: [ 'out', 'file' ], "level": "error" },
		warn   : { enableCallStack: true, appenders: [ 'out', 'file' ], "level": "warn" }
	}
} );

const logger = log4js.getLogger( loggerName );

logger.level = "info";

logger.addContext("custom", '');
logger.addContext("customTimestamp", fechaMexico);
export default logger;