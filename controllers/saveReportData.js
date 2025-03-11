import reportModel from "../models/reportModel.js";


async function saveReportData(req, res) {  
    try {
        const { datesTFind, dateProcess, reportId, state, result, file } = req.body;
        const report = new reportModel({ datesTFind, dateProcess, reportId, state, result, file });
        await report.save();
       return res.status(200).send('Reporte guardado');
    } catch (error) {
        console.error('Error '+error);
        return res.status(500).send('Error '+error);
    }
}

export {
    saveReportData
}
