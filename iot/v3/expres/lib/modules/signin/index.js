var express = require('express');
var bearerToken= require('../regtokau/strategy').bearerToken
var cons = require('tracer').console();
var conn = require('../../db/mysqldb')
// var bearerTokenAppLoc = require('../regtokau/strategy').bearerTokenAppLoc

var router = express.Router();

module.exports = function() {
  router.get('/', (req, res)=>{
    res.jsonp({message: "in root of signin module"})
  })

  router.get('/devs/:locid', bearerToken, (req,res)=>{
    if(!req.userTok.auth){
      var mess={auth:false, message: 'in get /signin/devs/:locid (not authoried)-'+req.userTok.message}
      cons.log(mess)
      res.jsonp(mess)
    }else{ 
      const{locid}=req.params   
      const qry  = conn.query('SELECT devid, description FROM devs WHERE locid = ? AND owner =?', [locid, req.userTok.emailId],(error,results)=>{
        console.log('qry.sql: ', qry.sql)
        console.log('error: ', error)
        console.log('results: ', results)
        res.jsonp({message: error, results})
      })
    }
  })

  router.get('/specs/:locid', bearerToken, (req, res)=>{
    if(!req.userTok.auth){
      var mess={auth:false, message: 'in get /signin/devs/:locid (not authoried)-'+req.userTok.message}
      cons.log(mess)
      res.jsonp(mess)
    }else{  
      const qry=conn.query('SELECT devs_auth.devid, devs.specs FROM devs_auth JOIN devs ON devs.devid = devs_auth.devid WHERE devs_auth.auth = ? AND devs.locid=?', [req.userTok.emailId, req.params.locid] ,(error,results)=>{
        console.log('qry.sql: ', qry.sql)
        console.log('error: ', error)
        console.log('results: ', results)
        res.jsonp(results)
      })
    }
  })

  router.post('/devauth', bearerToken, (req,res)=>{
    if(!req.userTok.auth){
      var mess={auth:false, message: 'in get /signin/devauth (not authoried)-'+req.userTok.message}
      cons.log(mess)
      res.jsonp(mess)  
    }else{
      const {email,devs} =req.body
      devs.map((d)=>{
        if(!d.ck){
          conn.query('DELETE from devs_auth WHERE devid =? AND auth=?', [d.devid,email])
        }else{
          const data ={devid:d.devid, auth:email}
          conn.query('INSERT INTO devs_auth SET ? ON DUPLICATE KEY UPDATE ?',[data,data])
        }
      })
      res.jsonp({message:'working on it'}) 
    } 
  })

  router.post('/apploc', bearerToken, (req,res)=>{
    if(!req.userTok.auth){
      var mess={auth:false, message: 'in get /signin/apploc (not authoried)-'+req.userTok.message}
      cons.log(mess)
      res.jsonp(mess)  
    }else{ 
      const {apploc,devs}= req.body
      console.log('apploc: ', apploc)
      console.log('devs: ', devs)
      const applocbl = {appid:apploc.appid, locid:apploc.locid, userid:'', role:'user'}
      const uapploc = {...applocbl, userid:req.userTok.emailId, auth:1}
      devs.map((d)=>{
        conn.query('SELECT owner FROM devs WHERE devid=?', d, (error,result)=>{
          const owner =  result[0] &&result[0].owner ? result[0].owner : undefined
          if(owner){
            const data = {...applocbl, userid:owner, auth:1}
            conn.query('INSERT INTO app_loc_user SET ? ON DUPLICATE KEY UPDATE ?;',[data,data])
          }
        })
      })
      conn.query('INSERT INTO app_loc SET ? ON DUPLICATE KEY UPDATE ?;\
      INSERT INTO app_loc_user SET ? ON DUPLICATE KEY UPDATE ?;',[apploc,apploc,uapploc,uapploc])
      res.jsonp({message:'working on it'}) 
    }  
  })

  router.post('/isalldevs', bearerToken, (req,res)=>{
    if(!req.userTok.auth){
      var mess={auth:false, message: 'in get /signin/apploc (not authoried)-'+req.userTok.message}
      cons.log(mess)
      res.jsonp(mess)  
    }else{
      console.log('req.body: ', req.body)
      const qry=conn.query('SELECT devid FROM devs WHERE devid IN (?)', [req.body], (error,result)=>{
        console.log('qry.sql`: ', qry.sql)
        let issame = true
        if(result.length !=req.body.length){
          issame =false
        }
        res.jsonp(issame)
      })
    }   
  })

  return router
}
