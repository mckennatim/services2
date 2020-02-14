var mysql = require('mysql')
var jwt = require('jwt-simple');
var cons = require('tracer').console();
// var env = require('../../../env.json')
// var cfg= env[process.env.NODE_ENV||'development']
var cfg = require('../../utilities').cfg
var conn = require('../../db/mysqldb')


var bearerToken = function(req,res, next){
	var toka = req.headers.authorization.split(' ')
	cons.log(toka[1])
	try { 
		var tokdata = jwt.decode(toka[1], cfg.secret)
		cons.log(tokdata)
	} catch(e){
		cons.log(e.message)
		req.userTok = {auth: false, message: e.message, emailId: ""}
		next()
		return
	} 
	//cons.log(tokdata)
	var retu = 'duch'
	conn.query('SELECT d.userid, d.devid, e.description as devdesc, d.bizid, d.appid,  a.desc as appdesc, d.role, d.auth FROM `devuserapp` d LEFT JOIN `devices` e ON d.devid=e.devid LEFT JOIN `apps` a ON d.appid=a.appid WHERE d.userid= ?', tokdata.email, function (error, results, fields) {
		if (error){
			cons.log(error.message)
			req.userTok = {auth: false, message: error.message}
			next()
			return
		}
		cons.log(results.length)
		if(!results){
			req.userTok = {auth: false, message: 'no user'}
			next()
			return
		}
		if(results.length>0){
			if(results.length==1 & results[0].devid==null){
				req.userTok = {auth: true, message: 'no apps', emailId: tokdata.email}
				next()
			}else{
				var resu =[]
				results.map((result)=>{
					resu.push(Object.assign({}, result))
				})
				cons.log('should be returning results')
				req.userTok = {auth: true, message: 'user has apps', apps: resu, emailId: tokdata.email}
				next()
			}
		}else{
			req.userTok = {auth: false, message: 'no user'}
			next()
		}	
	})
}

module.exports = {bearerToken}