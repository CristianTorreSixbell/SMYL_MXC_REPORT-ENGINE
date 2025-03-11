import CreateReport from '../controllers/createReportController.js';
import express from 'express';

const extractReportData = new CreateReport();
const router = express.Router();

router.post('/', extractReportData.extractReportData);

export default router;
