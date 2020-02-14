var express = require('express');
var jwt = require('jwt-simple');
var cons = require('tracer').console();
var env = require('../../../env.json')
var conn = require('../../db/mysqldb')
var bearerToken= require('./strategy').bearerToken

var cfg= env[process.env.NODE_ENV||'development']
var secret = cfg.secret

var router = express.Router();

module.exports = function() {
  router.get('/', function(req, res) {
    res.jsonp({message: "in root of registration module"})
  });

  router.post('/auth', function(req, res){
    cons.log("in api/reg/auth")
    cons.log(req.body)
    const payload = jwt.decode(req.body.token, secret)
    cons.log(payload)
      var query1= conn.query('SELECT auth FROM app_loc_user  WHERE userid = ? AND auth = 1 ', [payload.email, payload.appId], function (error, results) {
        cons.log(query1.sql)
        if(results.length==0){
          var mes = {auth:false, message: 'You are not authorized for this app at any location. Contact device owner'}
          cons.log(mes)
          res.jsonp(mes);
        }else {
          cons.log(results[0])
          res.jsonp({auth:true, message: payload.email +' is authorized for ' + payload.appId, payload:payload});
        }
      })
  })
  router.get('/locs', bearerToken, function(req,res){
    if(!req.userTok.auth){
      var mess={auth:false, message: 'in get /dedata/apps (not authoried)-'+req.userTok.message}
      cons.log(mess)
      res.jsonp(mess)
    }else{
      console.log('req.userTok: ', req.userTok)
      var qry= conn.query('SELECT DISTINCT locid FROM app_loc_user  WHERE userid = ? AND auth = 1', req.userTok.emailId, function (error, results) {
        console.log('qry.sql: ', qry.sql)
        console.log('results: ', results)
        res.jsonp({results, message:'huh'})
      })
    }
  })
  router.get('/apps/:loc', bearerToken, function(req,res){
    if(!req.userTok.auth){
      var mess={auth:false, message: 'in get /dedata/apps (not authoried)-'+req.userTok.message}
      cons.log(mess)
      res.jsonp(mess)
    }else{
      console.log('req.userTok: ', req.userTok)
      var qry= conn.query('SELECT appid, role FROM app_loc_user  WHERE userid = ? AND locid=? AND auth = 1', [req.userTok.emailId, req.params.loc], function (error, results) {
        console.log('qry.sql: ', qry.sql)
        console.log('results: ', results)
        res.jsonp({results, message:'huh'})
      })
    }
  })

  router.get('/la/:loc/:app/:role', bearerToken, function(req,res){
    if(!req.userTok.auth){
      var mess={auth:false, message: 'in get /la/loc/app/role (not authoried)-'+req.userTok.message}
      cons.log(mess)
      res.jsonp(mess)
    }else{
      const exp = Math.floor(Date.now()) + addDays(40)
      const payload = {
        app: req.params.app,
        email: req.userTok.emailId,
        loc: req.params.loc,
        role: req.params.role,
        exp:exp
      }
      var token = jwt.encode(payload, secret);
      console.log('payload: ', payload)
      const rev = {app:req.params.app, tdata:{email:req.userTok.emailId, token:token}}
      res.jsonp(rev)
    }
  })
  return router;
}

function addDays (x){
  return x*(24*60*60*1000)
}