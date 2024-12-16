import rowsQuantity from '../controllers/execSpController.js';
import express from 'express';
const newClassObj= new rowsQuantity();
const router = express.Router();

router.get('/', newClassObj.exectSp);

export default router;
