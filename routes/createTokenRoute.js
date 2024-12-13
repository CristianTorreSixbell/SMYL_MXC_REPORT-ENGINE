import express from 'express';
import GenerateToken from '../controllers/createTokenController.js';
import   {chargeData} from '../lib/dotenvExtractor.js';

chargeData();
const router = express.Router();
const generateTokenController = new GenerateToken ;
 
router.post('/', generateTokenController.generateToken);
 
export default router;