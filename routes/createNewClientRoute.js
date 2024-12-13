import InsertApplication from '../controllers/createNewClientController.js';
import express from 'express';

const newClassObj= new InsertApplication;
const router = express.Router();

router.post('/', newClassObj.insertApplication);

export default router;
