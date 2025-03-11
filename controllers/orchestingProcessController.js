import { chargeData } from "../lib/dotenvExtractor.js";


chargeData();




class OrchestProcess{
    constructor(){
        this.logEvent = this.logEvent.bind(this);
        this.orchestProcess = this.orchestProcess.bind(this);
        this.encryptionKey = process.argv[6] || null;
        if (this.encryptionKey.length !== 32) {
            throw new Error('Invalid encryption key length. Key must be 32 bytes.');
        }
    }
}