import ProcessReport from '../controllers/processReportController.js';
import express from 'express';

const router = express.Router();
const newProcessReport=new ProcessReport;

router.get('/', newProcessReport.extractInterval);

export default router;

