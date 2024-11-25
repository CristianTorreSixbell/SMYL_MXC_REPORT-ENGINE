import FileCreator from '../controllers/createFileController.js';
import express from 'express';

const fileCreator = new FileCreator();
const router = express.Router();

router.post('/', fileCreator.createFile);


export default router;
