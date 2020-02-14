var express = require('express');
var cons = require('tracer').console();
var conn = require('../../db/mysqldb')
var bearerToken = require('../regtokau/strategy').bearerToken

var router = express.Router();

module.exports = function() {
	router.get('/', function(req, res) {
		res.jsonp({message: "in root of dedata module"})		
	});
	router.get('/apps', bearerToken, function(req,res){
		//cons.log(req.userTok)
		//get descriptions of apps and add them in
		res.jsonp(req.userTok)
	})
	router.post('/dev', bearerToken, function(req,res){
		cons.log('in post dev')
		//cons.log(req.userTok)
		if(!req.userTok.auth){
			//console.log(req.userTok.message)
			var mess={message: 'not authoried-'+req.userTok.message}
			cons.log(mess)
			res.jsonp(mess)
		}else{
			var pdata=req.body
			var appArr = JSON.parse(pdata.apps)
			var ddata={devid:pdata.devid, userid:pdata.owner, bizid:pdata.bizid, role:'admin'}
			cons.log(ddata)
			cons.log(appArr)
			appArr.map((appid)=>{
				var bdata = {bizid: pdata.bizid, appid: appid }
				ddata.appid=appid
				console.log(ddata)
				var query1 = conn.query('INSERT INTO devuserapp SET ? ON DUPLICATE KEY UPDATE ?', [ddata,ddata], function(error,results,fields){
						if (error) {
							throw error;
							console.log({message: error})
						}else{
							console.log(results)
						}					
				})
				var query2 = conn.query('INSERT INTO bizapp SET ? ON DUPLICATE KEY UPDATE ?', [bdata,bdata], function(error,results,fields){
						if (error) {
							throw error;
							console.log({message: error})
						}else{
							console.log(results)
						}					
				})
			})
			// save a new device
			var query = conn.query('INSERT INTO devices SET ? ON DUPLICATE KEY UPDATE ?', [pdata,pdata], function(error,results,fields){
				if (error) {
					throw error;
					res.jsonp({message: error})
				}else{
					console.log(results)
					res.jsonp({message: results})
				}
			})
		}
	})
	return router
}