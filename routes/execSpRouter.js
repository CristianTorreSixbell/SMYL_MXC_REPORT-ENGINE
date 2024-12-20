import ExectSp from '../controllers/execSpController.js';
import express from 'express';
const newClassObj= new ExectSp;
const router = express.Router();

router.get('/', newClassObj.exectSp);

export default router;
