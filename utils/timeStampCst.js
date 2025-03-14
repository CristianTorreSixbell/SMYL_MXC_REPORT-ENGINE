import dayjs from 'dayjs';
import utc from 'dayjs/plugin/utc.js'; // Plugin para Day.js para trabajar con UTC
import timezone from 'dayjs/plugin/timezone.js'; 
dayjs.extend(utc);
dayjs.extend(timezone);
dayjs.tz.setDefault('America/Chicago');

const timeStamp = dayjs().subtract(6, 'hours') ;
const timeStamp2 = dayjs(timeStamp).toISOString();

export {
    timeStamp,
    timeStamp2
}



  const startDate = dayjs("2025-03-10T23:01:00.000Z").add(1, 'day');

            console.log('INFO', `Procesando fechas desde ${startDate.format("YYYY-MM-DD")}`);