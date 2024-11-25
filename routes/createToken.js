import GenerateToken from '../controllers/createToken.js';
import express from 'express';

const router = express.Router();
const generateToken = new GenerateToken();

router.post('/', generateToken.generateToken);

export default router;

