import TokenManagement from '../controllers/tokenManagement.js';   
import express from 'express';

const tokenManagement = new TokenManagement();
const router = express.Router();

router.post('/', tokenManagement.verifyToken);

export default router;
