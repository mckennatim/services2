var express = require('express');
var router = express.Router();
var cons = require('tracer').console();
var conn = require('../../db/mysqldb')
var bearerTokenCoid = require('../regtokau/strategy').bearerTokenCoid

function addAppId(req,res,next){
  req.appid = req.params.appid
  next()
}

module.exports = function() {
  router.get('/', function(req, res) {
      res.jsonp({ message: "in root of common module" })
  });
  router.get('/help/:appid', addAppId, bearerTokenCoid, function(req, res) {
    if (!req.userTok.auth) {
        var mess = { message: 'in get /common/help (not authorized)-' + req.userTok.message }
        cons.log(mess)
        res.jsonp(mess)
    } else {
      const qr = conn.query("SELECT q.appid, q.pagename, q.howto, q.qcontributor, q.qrank, q.qid , a.aid, a.hereshow, a.arank, a.acontributor FROM `helpq` q LEFT JOIN `helpa` a ON q.qid=a.qid WHERE appid = ? ORDER by q.appid, q.pagename, q.qrank desc, q.qid, a.arank desc;", req.params.appid,(err,result)=>{
        cons.log('err: ', err)
        cons.log('qr: ', qr.sql)
        cons.log('result: ', result)
        res.jsonp({message: 'authed', reqTok: req.userTok, results:result})
      })
    }
  })  
  router.put('/help/vote/:appid', addAppId, bearerTokenCoid, function(req, res) {
    if (!req.userTok.auth) {
        var mess = { message: 'in put /common/help/vote/appid (not authorized)-' + req.userTok.message }
        cons.log(mess)
        res.jsonp(mess)
    } else {
      const {vote} = req.body
      const{ vtype, idtype, qa, id, rank} = vote
      const tbl = 'help'+qa
      const qr = conn.query("UPDATE `"+tbl+"` SET `"+vtype+"` = ? WHERE `"+idtype+"` = ?", [rank, id],(err,result)=>{
        cons.log('err: ', err)
        cons.log('qr: ', qr.sql)
        cons.log('result: ', result)
        res.jsonp({message: 'authed', reqTok: req.userTok, results:result})
      })
    }
  })
  router.put('/help/ans/:appid', addAppId, bearerTokenCoid, function(req, res) {
    if (!req.userTok.auth) {
        var mess = { message: 'in put /common/help/ans (not authorized)-' + req.userTok.message }
        cons.log(mess)
        res.jsonp(mess)
    } else {
      console.log('req.body: ', req.body)
      let {ans}=req.body
      if(ans.aid>=9000 || ans.aid==null){
        //isert new
        delete ans.aid
        ans.arank=0
        ans.acontributor = req.userTok.emailid
        const qr = conn.query("INSERT INTO helpa SET ?; SELECT LAST_INSERT_ID();", ans,(err,result)=>{
          cons.log('err: ', err)
          cons.log('qr: ', qr.sql)
          cons.log('result: ', result)
          res.jsonp({message: 'authed', reqTok: req.userTok, results:result})
        })
      }else{
        //update existing
        const qr = conn.query("UPDATE helpa SET ? WHERE aid = ?", [ans, ans.aid],(err,result)=>{
          cons.log('err: ', err)
          cons.log('qr: ', qr.sql)
          cons.log('result: ', result)
          res.jsonp({message: 'authed', reqTok: req.userTok, results:result})
        })
      }
    }
  })  
  router.put('/help/ques/:appid', addAppId, bearerTokenCoid, function(req, res) {
    if (!req.userTok.auth) {
        var mess = { message: 'in put /common/help/ques/appid (not authorized)-' + req.userTok.message }
        cons.log(mess)
        res.jsonp(mess)
    } else {
      console.log('req.body: ', req.body)
      let {ques}=req.body
      if(ques.qid>=8000){
        //isert new
        delete ques.qid
        ques.qcontributor = req.userTok.emailid
        const qr = conn.query("INSERT INTO helpq SET ?; SELECT LAST_INSERT_ID();", ques,(err,result)=>{
          cons.log('err: ', err)
          cons.log('qr: ', qr.sql)
          cons.log('result: ', result)
          res.jsonp({message: 'authed', reqTok: req.userTok, results:result})
        })
      }else{
        //update existing
        const qr = conn.query("UPDATE helpq SET ? WHERE qid = ?", [ques, ques.qid],(err,result)=>{
          cons.log('err: ', err)
          cons.log('qr: ', qr.sql)
          cons.log('result: ', result)
          res.jsonp({message: 'authed', reqTok: req.userTok, results:result})
        })
      }
    }
  }) 
  router.delete('/help/del/:appid/:qa/:id', addAppId, bearerTokenCoid, function(req, res) {
    if (!req.userTok.auth) {
        var mess = { message: 'in put /common/help/:appid/:qa/:id (not authorized)-' + req.userTok.message }
        cons.log(mess)
        res.jsonp(mess)
    } else {
      console.log('req.params: ', req.params)
      const{qa,id}=req.params
      const tabl = 'help'+qa
      const idn = qa+'id'
      const qr = conn.query("DELETE FROM `"+tabl+"` WHERE `"+idn+"` = ?", id,(err,result)=>{
        cons.log('err: ', err)
        cons.log('qr: ', qr.sql)
        cons.log('result: ', result)
        res.jsonp({message: 'authed', reqTok: req.userTok, results:result})
      })
    }
  })
  return router;
}
