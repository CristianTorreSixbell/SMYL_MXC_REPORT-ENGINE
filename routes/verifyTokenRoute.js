import express from "express";
import VerifyToken from "../controllers/verifyTokenController.js";
const newClassObjet= new VerifyToken();
const router = express.Router();

router.post('/', newClassObjet.verifyToken);


export default router;