var app = require('express')()

var cons = require('tracer').console();
var jwt = require('jwt-simple');
var User = require('../app/models').moUser;
var AppInfo  = require('../app/models').moApp;
var mf = require('./funcs')
var env = require('../env.json')
//var cfg= env[process.env.NODE_ENV||'development']
var cfg= mf.cfg
// cons.log(cfg.base)
var fbCallback=cfg.auth.facebookAuth.callbackURL 


//module.exports = function(passport) {
module.exports = function(){
// normal routes ===============================================================
  
  app.get('/', function(req, res) {
    cons.log('in root')
    cons.log(req.query)
    res.render('hello.ejs');
  });

  app.get('/spa/:appid', function(req, res) {
    cons.log('doggy')
    console.log(req.params)
    cons.log(req.hostname)
    appInfo ={
      appId: req.params.appid,
      spaURL: req.headers.referer,
      apiURL: req.query.apiURL,
      cbPath: req.query.cbPath
    }
    mf.upsertSPAinfo(appInfo)
    appInfo.base=cfg.base
    cons.log(appInfo)
    res.render('signup.ejs',appInfo);
  });


    // process the signup form
  app.post('/signup', function(req,res){ 
    const appInfo=req.body
    console.log('appInfo: ', appInfo)
    cons.log(req.url)
    cons.log(req.headers.host)
    cons.log(req.hostname)
    cons.log(req.protocol)
    cons.log(req.headers.origin)
    var baseURL = req.protocol+"s://"+req.headers.host+cfg.base
    cons.log(baseURL)
    mf.sendToApi(appInfo.appId, appInfo.email, appInfo.apiURL, (message)=>{
      var cburl = appInfo.spaURL+appInfo.cbPath
      cons.log(message)
      mf.sendToSpa(cburl, appInfo.appId, appInfo.email, message, res)  
    })
  });
  
  return app
}