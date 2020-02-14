var mongoose = require('mongoose');

var Schema = mongoose.Schema;

var recoSchema = new Schema({
	id:String
})

var Reco= mongoose.model('Reco', recoSchema)
// Reco.findOne({id:"CYURD001:0"}, function(err, res){
// 	console.log(err)
// 	console.log(res)
// })

module.exports = {
	Reco: Reco
}
