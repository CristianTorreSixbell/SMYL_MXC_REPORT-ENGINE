import Client from 'ssh2-sftp-client';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
const __dirname = path.dirname(fileURLToPath(import.meta.url));



const sftp = new Client();

const config = {
  host: 'mft.mnyl.com.mx',
  port: 22,
  username: 'GENESYS-REPORTES',
  password: 'bJWFSGmR5qJfsEnnXcwW',
  algorithms: {
    cipher: [
      'aes128-ctr', 'aes192-ctr', 'aes256-ctr',
      'aes128-gcm', 'aes128-gcm@openssh.com',
      'aes256-gcm', 'aes256-gcm@openssh.com',
      'aes128-cbc', '3des-cbc',
      'aes192-cbc', 'aes256-cbc'
    ]
  }
};

async function listFiles() {
    try {
      await sftp.connect(config);
      const fileList = await sftp.list(remotePath);
      console.log('Files in remote directory:', fileList);
    } catch (err) {
      console.error('Error:', err);
    } finally {
      sftp.end();
    }
  }
const remotePath = '/GENESYS-REPORTES/';
const localFilePath = path.join(__dirname, '../static/reports/SMNYL_EMAIL_REPORT_2025-03-09.csv');
const remoteFilePath = path.join(remotePath, 'SMNYL_EMAIL_REPORT_2025-03-09.csv');

// Create a local text file
fs.writeFileSync(localFilePath, 'This is a test file.');

async function uploadFile() {
  try {
    await sftp.connect(config);
    await sftp.put(localFilePath, remoteFilePath);
    console.log('File uploaded successfully');
  } catch (err) {
    console.error('Error:', err);
  } finally {
    sftp.end();
  }
}

uploadFile();
listFiles()