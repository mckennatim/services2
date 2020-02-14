var express = require('express');
var jwt = require('jwt-simple');
var cons = require('tracer').console();
var env = require('../../../env.json')
var conn = require('../../db/mysqldb')

var cfg= env[process.env.NODE_ENV||'development']
var db = cfg.db
var secret = cfg.secret

var router = express.Router();

module.exports = function() {
	router.get('/', function(req, res) {
		res.jsonp({message: "in root of registration module"})		
	});

	router.post('/auth', function(req, res){
		const payload = jwt.decode(req.body.token, secret)
		cons.log(payload)
		if (payload.email==cfg.super){
			//if you are a superuser add if no there the superuser records
			const superdev = "CYURD14I"
			cons.log('your are a superuser')
			var ins = {devid: superdev, userid: payload.email, appid: 'superapp', role:'super', auth: true }
			var ins2 = {devid: superdev, userid: payload.email, appid: 'admin', role:'admin', auth: true }
			var ins3 = {devid: superdev, userid: payload.email, appid: payload.appId, role:'admin', auth: true }
			conn.query('INSERT INTO devuserapp SET ?', ins , function (error, results, fields) {
			  if(error) {
			  	console.log(error.code)
			  }else {
			  	console.log(results.insertId);
			  }
			})
			conn.query('INSERT INTO devuserapp SET ?', ins2 , function (error, results, fields) {
			  if(error) {
			  	console.log(error.code)
			  }else {
			  	console.log(results.insertId);
			  }
			})
			conn.query('INSERT INTO devuserapp SET ?', ins3 , function (error, results, fields) {
			  if(error) {
			  	console.log(error.code)
			  }else {
			  	console.log(results.insertId);
			  }
			})
			res.jsonp({message: 'authenticated a superuser'});
		}else{
			//see if there are any apps/devices for that user or tell them they are shit outa luck and should contact the bossman to add your email to the system, meeanwhile you can put them in with no apps or devices or auth
			conn.query('SELECT * FROM devuserapp  WHERE userid = ?', payload.email, function (error, results, fields) {
				if(results.length==0){
					var ins4 = {userid: payload.email, appid: payload.appId, auth: true }
					conn.query('INSERT INTO devuserapp SET ? ', ins4 , function (error, results, fields){
							res.jsonp({message: 'added a new user'});
						})
				}else{
					res.jsonp({message: 'user exists'});
				}

			})
		}
	})
	return router;
}

