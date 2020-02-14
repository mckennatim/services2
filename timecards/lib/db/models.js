var mongoose = require('mongoose');

var Schema = mongoose.Schema;

var deviceSchema = new Schema({
    devid: { type: String, index: { unique: true } },
    devpwd: String,
    devdesc: String,
    server: String,
    sensortype: String,
    users: [{
        email: String,
        apps: [{
            appid: String,
            role: String,
            auth: Boolean
        }]
    }],
    loc: {
        lat: Number,
        lng: Number,
        timezone: String,
        address: String,
        zipcode: String
    }
}, { strict: false });

var schedSchema = new Schema({
    devid: String,
    sr: [{
        id: Number,
        type: String,
        days: [{
            day: Number,
            sched: []
        }]
    }]
})

var userSchema = new Schema({
    email: { type: String, index: { unique: true } },
    devices: [String]
}, { strict: false });

var appSchema = mongoose.Schema({
    appId: String,
    spaURL: String,
    apiURL: String,
    mqtt: String,
    ws: String,
    node: String
})


var recoSchema = new Schema({
    id: String
})

var Reco = mongoose.model('Reco', recoSchema)

module.exports = {
    Device: mongoose.model('Device', deviceSchema),
    Uuser: mongoose.model('Uuser', userSchema),
    App: mongoose.model('App', appSchema),
    Sched: mongoose.model('Sched', schedSchema),
    Reco: Reco
}