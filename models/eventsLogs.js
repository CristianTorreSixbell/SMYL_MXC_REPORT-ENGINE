import mongoose from 'mongoose';

const { Schema } = mongoose;

const eventLogSchema = new Schema({
    reportid: {
        type: String,
        required: true
    },
    event: {
        type: String,
        required: true
    },
    eventMsg: {
        type: String,
        required: true
    },
    eventDate: {
        type: Date,
        required: true,
        default: Date.now()
    }
});


eventLogSchema.index({ eventDate: 1 }, { expireAfterSeconds: 2592000 }); // 30 days

const eventLogModel = mongoose.model('eventLogs', eventLogSchema);

export default eventLogModel;