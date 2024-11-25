import dayjs from 'dayjs';
import  utc from 'dayjs/plugin/utc.js'; // Plugin para Day.js para trabajar con UTC
import timezone  from 'dayjs/plugin/timezone.js'; 
dayjs.extend(utc);
dayjs.extend(timezone);
dayjs.tz.setDefault('America/Chicago');

const timeStamp ='['+ dayjs().subtract(6,'hours').format()+']';



export{
    timeStamp
};