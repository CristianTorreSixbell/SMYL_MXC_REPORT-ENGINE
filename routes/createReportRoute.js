import ExtractReportData from '../controllers/createReportController.js';
import express from 'express';

const extractReportData = new ExtractReportData();
const router = express.Router();

router.post('/', extractReportData.extractReportData);

export default router;
