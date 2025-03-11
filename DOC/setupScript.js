import { exec } from 'child_process';
//import {setupDatabase} from './dbConfig.js';    

function runCommand(command) {
  return new Promise((resolve, reject) => {
    exec(command, (error, stdout, stderr) => {
      if (error) {
        console.error(`Error ejecutando el comando: ${error.message}`);
        reject(error);
      }
      if (stderr) {
        console.warn(`Advertencia: ${stderr}`);
      }
      resolve(stdout.trim());
    });
  });
}

 

// Función principal
async function main() {
  try {
    console.log("Instalando dependencias necesarias...");

    // Comandos de instalación de dependencias
    const commands = [
        "npm install connect-timeout ",
        "npm install cors ",
        "npm install crypto ",
        "npm install dayjs ",
        "npm install dotenv ",
        "npm install express ",
        "npm install jsonwebtoken  ",
        "npm install log4js ",
        "npm install mongoose ",
        "npm install mssql ",
        "npm install node-cron ",
        "npm install objects-to-csv  ",
        "npm install pm2 ",
        "mongosh"
    ];

    for (const command of commands) {
        
      console.log(` Ejecutando: ${command} `);  
      const result = await runCommand(command);
      if(command.includes('dotenv')){
        chargeData();
      }
      if(command.includes("mongosh")){
         await runCommand(`USE ` );
         await runCommand(`db.createUser({user: "@$MtNY@",pwd: "b3^94O,g3hhy",roles: [ { role: "dbOwner", db: "${process.argv[5]}" } ]});`);
         await runCommand(`USE admin` );
         await runCommand(`db.createUser({user: "@$MtNY@",pwd: "b3^94O,g3hhy",roles: [ { role: "dbOwner", db: "admin" } ]});`);
         await runCommand('exit()')
      }    
      console.log(result); 
    }

    console.log("Dependencias instaladas correctamente.");

    // Configurar base de datos
    //await setupDatabase();
  } catch (error) {
    console.error(`Error en el proceso: ${error.message}`);
  }
}

main();

 
 