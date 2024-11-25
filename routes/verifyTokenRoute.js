import express from "express";
import VerifyToken from "../controllers/verifyTokenController.js";

const router = express.Router();

const verifyTokenRouter = (encryptionKey) => {
    const verifyToken = new VerifyToken(encryptionKey);

    router.post("/", verifyToken.verifyToken);

    return router;
};

export default verifyTokenRouter;