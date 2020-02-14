var express = require('express');
var jwt = require('jwt-simple');
var cons = require('tracer').console();
var conn = require('../../db/mysqldb')
var env = require('../../../env.json')
var cfg = env[process.env.NODE_ENV || 'development']
var secret = cfg.secret
var bearerTokenCoid = require('../regtokau/strategy').bearerTokenCoid
var bearerTokenApp = require('../regtokau/strategy').bearerTokenApp
const bk = require('./backup')

var router = express.Router();
function addAppId(req,res,next){
  req.appid = 'co'
  next()
}
module.exports = function() {
  router.get('/', function(req, res) {
    res.jsonp({ message: "in root of co module" })
  });
  router.get('/co', addAppId, bearerTokenCoid, function(req, res) {
    if (!req.userTok.auth) {
        var mess = { message: 'in get /co/co (not authorized)-' + req.userTok.message }
        res.jsonp(mess)
    } else {
      var getco = conn.query('SELECT c.*, r.* FROM `timecards`.`cosr` r JOIN `timecards`.`co` c ON c.coid=r.coid AND r.effective <= CURDATE() AND r.coid = ? ORDER BY r.effective DESC LIMIT 1 ', req.userTok.coid, function(error, results) {
        cons.log(getco.sql)
        cons.log(error)
        cons.log(results)
        res.jsonp({results: results[0], binfo: req.userTok})
      })
    }
  })

  router.get('/bkup/:coid', bearerTokenApp, function(req, res) {
    if (!req.userTok.auth) {
        var mess = { message: 'in get /co/bkup (not authorized)-' + req.userTok.message }
        res.jsonp(mess)
    } else {
      console.log('req.userTok: ', req.userTok)
      cons.log('req.params: ', req.params)
      /*check if the coid in the url actually is this user's */
      var found = req.userTok.cos.find((f)=>f.coid==req.params.coid)
      console.log('found: ', found.coid)
      if(found && found.role=='partner'){
        //res.jsonp({toq:req.userTok, params: req.params})
        bk.createBkDb(found.coid, ()=>{
          console.log('returned')
          const fname = './'+found.coid+'.sql'
          bk.emailBkup(req.userTok.emailid, found.coid, (ret)=>{
            console.log('ret: ', ret)
            bk.unlinkBkup(fname, (uret)=>{
              console.log('uret: ', uret)
            })
          })
          console.log('fname: ', fname)
          res.jsonp({message: `${fname} is backed up. Check your email for attached file`})
        })
      }else{
        res.jsonp({message:'not found coid or not partner for that coid'})
      }
    }
  })

  router.delete('/delete/:coid', bearerTokenApp, function(req, res) {
    if (!req.userTok.auth) {
        var mess = { message: 'in get /co/delete/:coid (not authorized)-' + req.userTok.message }
        res.jsonp(mess)
    } else {
      console.log('req.userTok: ', req.userTok)
      cons.log('req.params: ', req.params)
      /*check if the coid in the url actually is this user's */
      var found = req.userTok.cos.find((f)=>f.coid==req.params.coid)
      console.log('found: ', found.coid)
      if(found && found.role=='partner'){
        bk.delCoidsLike(found.coid,()=>{
          res.jsonp({message:`all records for ${found.coid} have been deleted`})
        })

      }else{
        res.jsonp({message:'not found coid or not partner for that coid'})
      }
    }
  })

  router.get('/demo', bearerTokenApp, function(req,res){
    if (!req.userTok.auth) {
      var mess = { message: 'in get /co/demo (not authorized)-' + req.userTok.message }
      res.jsonp(mess)
    } else {  
      cons.log('req.userTok: ', req.userTok)
      cons.log('req.params: ', req.params)
      const demomin = 2
      bk.startDemo(req.userTok.emailid, demomin, (coid, goodtil)=>{
        console.log('coid: ', coid)
        const exp = Math.floor(Date.now()) + addDays(40)
        cons.log('exp: ', exp)
        var payload = {
          coid: coid,
          role: 'partner',
          appid: 'signup',
          emailid: req.userTok.emailid,
          exp: exp
        };
        var token = jwt.encode(payload, secret);
        res.jsonp({result:true, goodtil:goodtil, coid:coid,token:token, emailid:req.userTok.emailid})
      })
    }  
  })
  router.post('/co', addAppId, bearerTokenCoid, function(req, res) {
    if (!req.userTok.auth) {
        var mess = { message: 'in post /co/co (not authorized)-' + req.userTok.message }
        res.jsonp(mess)
    } else {
      cons.log('req.userTok: ', req.userTok)
      cons.log('req.body.newco: ', req.body.newco)
      const {newco} = req.body
      let acosr = {...newco}
      delete acosr.id
      acosr.goodtil=req.userTok.goodtil
      acosr.coid =req.userTok.coid
      let aco={}
      const splitnewco = (arr)=>{
        aco.coid = acosr.coid
        arr.map((a)=>{
          aco[a]=acosr[a]
          delete acosr[a]
        })
      }
      splitnewco(['goodtil', 'name', 'street', 'city', 'st', 'zip', 'fedein', 'stein'])
      cons.log('aco: ', aco)
      cons.log('acosr: ', acosr)
      var getco = conn.query('UPDATE `co` SET ? WHERE coid=?; INSERT INTO `cosr` SET ? ON DUPLICATE KEY UPDATE ? ;', [aco, req.userTok.coid, acosr, acosr], function(error, results) {
        cons.log(getco.sql)
        cons.log(error)
        cons.log(results)
        res.jsonp({results, binfo: req.userTok})
      })
    }
  })
  return router
}


function addDays (x){
  return x*(24*60*60*1000)
}