import {saveReportData} from '../controllers/saveReportData.js';
import express from 'express';

const router=express.Router();

router.post('/',saveReportData);

export default router;