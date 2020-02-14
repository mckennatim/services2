var jwt = require('jwt-simple');
var cfg = require('../../utilities').cfg
var get = require('../../utilities').get
var conn = require('../../mysqldb')
var cons = require('tracer').console();
const appids = cfg.appIds
// console.log('appids: ', appids)


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
  console.log('appids: ', appids)
  if(appids.includes(tokdata.appId)){
    cons.log(tokdata)
    var q= conn.query('SELECT lids FROM `users` WHERE email= ? ', tokdata.email, function (error, results) {
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


module.exports = { bearerToken }