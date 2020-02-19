var express = require('express');
var jwt = require('jwt-simple');
var env = require('../../../env.json')
var cfg = env[process.env.NODE_ENV || 'development']
var secret = cfg.secret
var cons = require('tracer').console();
var conn = require('../../mysqldb')

var router = express.Router();

module.exports = function() {
  router.get('/', function(req, res) {
    res.jsonp({ message: "in root of s2g registration module" })
  });

  router.post('/auth', function(req, res) {
    cons.log("in s2g api/reg/auth")
    cons.log('req.body: ', req.body)
    const payload = jwt.decode(req.body.token, secret)
    const emailid = payload.email
    const appid = payload.appId
    cons.log(payload)
    if(cfg.appIds.includes(appid)){
      const user = emailid.split('@')[0]
      const insobj = {user, email: emailid}
      const q = conn.query(' \
      INSERT INTO `users` SET ? ON DUPLICATE KEY UPDATE ?' 
      ,[insobj,insobj], (errors,results)=>{
        if(errors){
          res.jsonp({ auth: false, message: `server error: ${errors}`, payload: payload });
        }else{
          res.jsonp({ auth: true, message: payload.email + ' is authenticating for ' + payload.appId, payload: payload });
        }
        
      }) 
    }else{
      res.jsonp({ auth: false, message: `${payload.appId} doesn't work here`, payload: payload });
    }
  })

  return router;
}
