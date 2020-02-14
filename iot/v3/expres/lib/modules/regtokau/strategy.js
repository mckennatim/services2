// var mysql = require('mysql')
var jwt = require('jwt-simple');
var cons = require('tracer').console();
var cfg = require('../../utilities').cfg
var get = require('../../utilities').get
var conn = require('../../db/mysqldb')


var bearerToken = function(req,res, next){
  if(!get('req.headers.authorization', req)){
    req.userTok = {auth: false, message: "no authorization header", emailId: ""}
    next()
    return
  }
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
  if(tokdata.appId=='signin'){
    cons.log(tokdata)
    var q= conn.query('SELECT locid FROM app_loc_user WHERE userid= ? ', tokdata.email, function (error, results) {
      cons.log(q.sql)
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
          req.userTok = {auth: true, message: 'user has apps', emailId: tokdata.email, appId: tokdata.appId}
          next()
        }
      }else{
        req.userTok = {auth: false, message: 'no user'}
        next()
      }
    })
  }else{
    req.userTok = {auth: false, message: "not the right appid", emailId: tokdata.email}
    next()
    return
  }
}

var bearerTokenApp = function(req,res, next){
  if(!get('req.headers.authorization', req)){
    req.userTok = {auth: false, message: "no authorization header", emailId: ""}
    next()
    return
  }
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
  cons.log(tokdata)
  var q= conn.query('SELECT userid, devid, role FROM user_app_loc WHERE userid= ? AND appid=?', [tokdata.email,tokdata.appId], function (error, results) {
    cons.log(q.sql)
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
    cons.log(results[0].devid)
    req.userTok = {auth: true, message: 'user has apps', emailId: tokdata.email, appId: tokdata.appId}
    if(tokdata.appId=='builder'){
      req.userTok.baseDevId=results[0].devid
      req.userTok.bizId=results[0].role
    }
    next()
    return
  })
}
var bearerTokenAppLoc = function(req,res, next){
  if(!get('req.headers.authorization', req)){
    req.userTok = {auth: false, message: "no authorization header", emailId: ""}
    next()
    return
  }
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
  cons.log(tokdata)
  var q= conn.query('SELECT userid, appid, locid, role FROM app_loc_user WHERE userid= ? AND appid=? AND locid=? AND role=?', [tokdata.email,tokdata.app, tokdata.loc, tokdata.role], function (error, results) {
    cons.log(q.sql)
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
    cons.log(results[0].locid)
    req.userTok = {
      auth: true, 
      message: 'user has apps', 
      email: tokdata.email, 
      app: tokdata.app, 
      loc: tokdata.loc,
      role: tokdata.role
    }
    if(tokdata.appId=='builder'){
      req.userTok.baseDevId=results[0].devid
      req.userTok.bizId=results[0].role
    }
    next()
    return
  })
}
module.exports = {bearerToken, bearerTokenApp, bearerTokenAppLoc}
