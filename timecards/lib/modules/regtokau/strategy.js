var jwt = require('jwt-simple');
var cfg = require('../../utilities').cfg
var get = require('../../utilities').get
var conn = require('../../db/mysqldb')
var cons = require('tracer').console();

var bearerTokenApp = function(req, res, next) {
  // cons.log('req.body: ', req.body)
  if (!get('req.headers.authorization', req)) {
    req.userTok = { auth: false, message: "no authorization header", emailId: "" }
    next()
    return
  }
  var toka = req.headers.authorization.split(' ')
  try {
    var tokdata = jwt.decode(toka[1], cfg.secret)
    // cons.log('tokdata: ', tokdata)
  } catch (e) {
    req.userTok = { auth: false, message: e.message, emailId: "" }
    next()
    return
  }
  conn.query('SELECT w.emailid, w.role, w.active, c.coid, c.goodtil, a.appid FROM rolewho w RIGHT JOIN `roleapp` a ON a.`role`= w.`role` LEFT JOIN co c ON c.coid= w.coid WHERE w.emailid = ? AND a.appid = ? AND w.active=1', [tokdata.email, tokdata.appId], function(error, results) {
    //cons.log('c.goodtil > CURDATE(): ', c.goodtil > CURDATE() ? true : false)
    // cons.log('results: ', results)
    // cons.log('q1.sql: ', q1.sql)
    if (error) {
      req.userTok = { auth: false, message: error.message }
      next()
      return
    }
    if (!results) {
      req.userTok = { auth: false, message: 'no user ' }
      next()
      return
    }
    if (results.length==0){
      if(tokdata.appId=='signup'){
        req.userTok = { auth: true, message: 'authorized but unknown user in signup', emailid: tokdata.email, appid:tokdata.appId}
        next()
        return      
      }else{
        req.userTok = { auth: false, message: 'zero length coids ' }
        next()
        return      
      }
    }//hay at least 1 result
    const cos = results.map((res)=>res)
    req.userTok = { auth: true, message: 'user has apps', emailid: tokdata.email, appid:tokdata.appId, cos:cos}
    next()
    return
  })
}
var bearerTokenCoid = function(req, res, next) {
  // console.log('req.appid: ', req.appid)//from addAppId middleware
  if (!get('req.headers.authorization', req)) {
    req.userTok = { auth: false, message: "no authorization header", emailId: "" }
    next()
    return
  }
  var toka = req.headers.authorization.split(' ')
  try {
    var tokdata = jwt.decode(toka[1], cfg.secret)
  } catch (e) {
    req.userTok = { auth: false, message: e.message, emailId: "" }
    next()
    return
  }
  // cons.log('tokdata in BearerTokenCoid: ', tokdata)
  conn.query('SELECT w.emailid, w.role, w.active, c.coid, c.goodtil, a.appid FROM rolewho w LEFT JOIN `roleapp` a ON a.`role`= w.`role` LEFT JOIN co c ON c.coid= w.coid WHERE w.emailid = ? AND c.goodtil > CURDATE() AND a.appid = ? AND c.coid = ? AND w.active=1', [tokdata.emailid, req.appid, tokdata.coid], function(error, results){
    // cons.log('qco results: ', results)
    // cons.log('qco.sql: ', qco.sql)
    if (error) {
      req.userTok = { auth: false, message: error.message }
      next()
      return
    }
    if (!results || results.length==0) {
      req.userTok = { auth: false, message: 'user not authorized for this app co. not active' }
      next()
      return
    }
    // cons.log('results: ', results)
    req.userTok = { auth: true, message: 'user has apps for coid', emailid: tokdata.emailid, appid:tokdata.appid, coid:tokdata.coid, role:tokdata.role, goodtil:results[0].goodtil}
    next()
    return
  })
}
var bearerTokenCoidApps = function(req, res, next) {
  if (!get('req.headers.authorization', req)) {
    req.userTok = { auth: false, message: "no authorization header", emailId: "" }
    next()
    return
  }
  var toka = req.headers.authorization.split(' ')
  try {
    var tokdata = jwt.decode(toka[1], cfg.secret)
    cons.log('tokdata: ', tokdata)
  } catch (e) {
    req.userTok = { auth: false, message: e.message, emailId: "" }
    next()
    return
  }
  const qco =conn.query('SELECT w.emailid, w.role, w.active, c.coid, c.goodtil, a.appid FROM rolewho w LEFT JOIN `roleapp` a ON a.`role`= w.`role` LEFT JOIN co c ON c.coid= w.coid WHERE w.emailid = ? AND c.goodtil > NOW() AND c.coid = ? AND w.active=1', [tokdata.emailid, tokdata.coid], function(error, results){
    cons.log('qco results: ', results)
    cons.log('qco.sql: ', qco.sql)
    if (error) {
      req.userTok = { auth: false, message: error.message }
      next()
      return
    }
    if (!results || results.length==0) {
      req.userTok = { auth: false, message: 'no user or active coid' }
      next()
      return
    }
    cons.log('results: ', results)
    const ares = results.map((r)=>r)
    req.userTok = { auth: true, message: 'user has apps for coid', results: ares}
    next()
    return
  })  
}
module.exports = { bearerTokenApp, bearerTokenCoid, bearerTokenCoidApps }