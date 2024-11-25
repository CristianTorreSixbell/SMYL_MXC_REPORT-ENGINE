import path from 'path'
import Client from 'ssh2-sftp-client';
import logger from './Logger.js';
// import dayjs from 'dayjs';
import { fileURLToPath } from 'url';
import {SFTPPORT,SFTPHOST,SFTPUSER,SFTPDIR,SFTPPASS} from './dotenv.js  ';

const __filename=fileURLToPath(import.meta.url);
const __dirname= path.dirname(__filename);
  let sftp ;



  class SftpConnector{
    constructor(host,pass,keys){

    }
    async getActualDayFolderContent(date,sftp) {
      try {
        const baseDir=SFTPDIR;
        const dirToExplore = `${baseDir}${date}`; 
        console.log('[INGESTOR-DOWNLOADER][getActualDayFolderContent(INFO)]: Conexión SFTP establecida.');
       const fileList = await sftp.list(dirToExplore);
        await sftp.end();
        return fileList;
        
      } catch (err) {
        await sftp.end();
        console.error('Error en la conexión SFTP:', err);
      } finally {
        await sftp.end();
        console.log('Conexión SFTP cerrada.');
      }
    }
    
    async conectToSftp(){
      try{
        logger.info(`[INGESTOR-METADATA][conectToSftp(INFO)]: Connectando al Sftp... `);
    
        const host='189.205.81.141'
        const user=SFTPUSER
        const pass=SFTPPASS
        const port=SFTPPORT
       
        const conectionOptions={
          host: host,
          port: parseInt(port),
          username: user,
          password: pass,
          algorithms: {
            kex: ['diffie-hellman-group1-sha1', 'diffie-hellman-group14-sha1'],
            serverHostKey: ['ssh-rsa']
          }
        };
        if(! sftp){
          sftp= new Client();
          logger.info(`[INGESTOR-METADATA][conectToSftp(INFO)]: Inicializando conexion a sftp `);
        }
        logger.info(conectionOptions)
        await sftp.connect(conectionOptions);
     
        logger.info(`[INGESTOR-METADATA][conectToSftp(INFO)]: Conexión Sftp establecida correctamente `);
        return {
          "status":200,
          "data":sftp 
        };    
      }catch(e){
        logger.error(`[INGESTOR-METADATA][conectToSftp(ERROR)]: No se logro conectar mediante sftp  ${e}`);
    
        return {
          "status":500,
          "data":`[INGESTOR-METADATA][conectToSftp(ERROR)]: No se logro conectar mediante sftp  ${e}` 
        };
      }
    }
    
    async disconectSftp(sftp){
      try{
        if(! sftp){
          throw new Error(`Obejeto de conexión Sftp invalido`);
        }
        await sftp.end();
        logger.info(`[INGESTOR-METADATA][disconectSftp(INFO)]: Conexión sftp desconectada correctamente `);
      }catch(e){
        logger.error(`[INGESTOR-METADATA][disconectSftp(ERROR]: No se logro desconectar la conexion ${e}`);
        await sftp.end();
      }
    }
    
    async downloadFile(sftp,filePath,localDir){
      try{  
        if( ! sftp|| ! filePath|| ! localDir){
          throw new Error(`Parametros de ingreso invalido`);
        }
        try{
        await sftp.get( filePath,localDir+'archivo.wav');
        }catch(err){
          throw Error(err);
        }
        logger.info(`[INGESTOR-METADATA][downloadFile(INFO)]: Se descargo el arhivo de manera exitosa  `);
        return{
          "status":200,
          "data":`[INGESTOR-METADATA][downloadFile(INFO)]: Se descargo el arhivo de manera exitosa  `
        };
      }catch(e){
        logger.error(`[INGESTOR-METADATA][downloadFile(ERROR)]: No se logro descargar el archivo ${e} `);
        return{
          "status":500,
          "data":`[INGESTOR-METADATA][downloadFile(ERROR)]: No se logro descargar el archivo ${e} `
        };
      }
    }
    
    
    async getExcellInfo(sftp,filePath,intention){
      try{
        if(!sftp||!filePath||!intention){
          throw new Error(`Faltan parametros `);
        } 
        logger.info(filePath)
        let fileContent ;
        if(intention.toString().toLowerCase().includes('get')){
          fileContent=await sftp.get(filePath);///Fanafesa/2024-04/meta.xlsx //decarga array buffer de arhcivo 
        }else if(intention.toString().toLowerCase().includes('list')) {
          const result=await sftp.list(filePath);
          fileContent=[];
          ///Fanafesa/2024-04/ lista de archivos que contiene
        
          for(let file of result){
            if(file && !file.name.endsWith('.xlsx')){ 
              fileContent.push(file.name);
            }
          }
           
        }
        
        if(!fileContent ){
          throw new Error(`No se encotraron resultados de la busqueda `)
        }
        
        logger.info(`[INGESTOR-METADATA][getExcellInfo(INFO)]: Se logro extraer la información del archivo excell `);
        return{
          "status":200,
          "data":fileContent
        };
      }catch(e){
        logger.error(`[INGESTOR-METADATA][getExcellInfo(ERROR)]: NO se logro extraer la información del archivo excell ${e}`);
        return{
          "status":500,
          "data":`[INGESTOR-METADATA][getExcellInfo(ERROR)]: NO se logro extraer la información del archivo excell ${e}`
        };
      }
    }
     
  }

export {
  getActualDayFolderContent,
  conectToSftp,
  downloadFile,
  disconectSftp,
  getExcellInfo
}
// console.time('Process');
// const sftpR=await conectToSftp();
// const sftpC =sftpR.data;
//  const metadataExcell='/Fanafesa/2024-02/meta.xlsx';
//  const fileToFind=await getExcellInfo(sftpC,metadataExcell,'get');
//  console.log(fileToFind);
//  await disconectSftp(sftpC)
//  console.timeEnd('Process');