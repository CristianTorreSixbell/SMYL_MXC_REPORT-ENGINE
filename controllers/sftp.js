import Client from 'ssh2-sftp-client';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename); 
 

async function testSftpConnection() {
    const sftp = new Client();
    const config = {
        host: 'mft.mnyl.com.mx',
        port: 22,
        username: 'GENESYS-REPORTES',
        password: 'bJWFSGmR5qJfsEnnXcwW'
    };

    try {
        await sftp.connect(config);
        console.log('Conexión SFTP exitosa');

        const folderPath = '/GENESYS-REPORTES';
        const fileList = await sftp.list(folderPath);
        console.log('Archivos en la carpeta:', fileList);

        await sftp.end();
    } catch (err) {
        console.error('Error en la conexión SFTP:', err);
    }
}

async function createAndSendFile() {
    const sftp = new Client();
    const config = {
        host: 'mft.mnyl.com.mx',
        port: 22,
        username: 'GENESYS-REPORTES',
        password: 'bJWFSGmR5qJfsEnnXcwW'
    };

    const localFilePath = path.join(__dirname, '../static/reports/SMNYL_EMAIL_REPORT_2025-03-09.csv');
    const remoteFilePath = '/GENESYS-REPORTES/SMNYL_EMAIL_REPORT_2025-03-09.csv';

    // Crear el archivo de texto localmente
    fs.writeFileSync(localFilePath, 'Hola, esto es una prueba');

    try {
        await sftp.connect(config);
        console.log('Conexión SFTP exitosa');

        // Enviar el archivo al servidor SFTP
        await sftp.put(localFilePath, remoteFilePath);
        console.log('Archivo enviado exitosamente');

        await sftp.end();
    } catch (err) {
        console.error('Error en la conexión SFTP:', err);
    } finally {
        // Eliminar el archivo local después de enviarlo
        fs.unlinkSync(localFilePath);
    }
}

testSftpConnection();
createAndSendFile();