var express = require('express');
var router = express.Router();

module.exports = function() {
	router.get('/', function(req, res) {
		res.jsonp({message: "in root of mqtt module"})		
	});
	router.get('/time', function (req,res){
	});
	return router;
}