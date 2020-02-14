var mongoose = require('mongoose');
var Schema = mongoose.Schema;
var devicesSchema = new Schema({
	devid: {type:String, index:{unique: true}},
	domain: String,
	users: [{
		email: String,
		apps: [{
			appId: String,
			role: String,
			auth: Boolean 
		}]
	}],
	loc: {
		lat: Number,
		lng: Number,
		timezone: String,
		address: String
	}
}, { strict: false });

var dModel = mongoose.model('Device', devicesSchema);

module.exports = dModel;
