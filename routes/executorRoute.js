import Executor from '../controllers/executorController.js';
import express from 'express';

const router=express.Router();
const newExecutor =new Executor 
const mainApps=newExecutor.start 

router.get('/',mainApps);

export default router
