var express = require('express');
var cons = require('tracer').console();
var conn = require('../../mysqldb')
var bearerToken = require('../regtokau/strategy').bearerToken

var router = express.Router();

module.exports = function() {
  router.get('/', (req, res)=>{
    res.jsonp({message: "in root of s2g module"})
  })

  router.get('/lists', bearerToken, function(req,res){
    if(!req.userTok.auth){
      var mess={message: 'in get /s2g/lists (not authoried)-'+req.userTok.message}
      cons.log(mess)
      res.jsonp({err:mess})
    }else{
      var q =conn.query('SELECT * FROM users WHERE email=?;', req.userTok.emailId , function(error, results){
        let lists =[]
        let err
        if(!error){
          lists= JSON.parse(results[0].lids)
        }else{
          err =error.code
        }
        res.jsonp({lists, user:results[0].user, email:results[0].email ,err})
      })
    }
  })

  router.get('/items/:lid', bearerToken, function(req,res){
    if(!req.userTok.auth){
      var mess={message: 'in get /s2g/lists (not authoried)-'+req.userTok.message}
      res.jsonp({err:mess})
    }else{
      const lid = req.params.lid
      const lidinfo = JSON.parse(req.userTok.lids)
      // console.log('lidinfo: ', lidinfo)
      const lididx = lidinfo.findIndex((l)=>l.lid==lid)
      if(lididx > -1){
        var q =conn.query('SELECT lid, product, done, jsod,loc FROM items WHERE lid=? AND done=0 ORDER BY product;', lid , function(error, results){
          let items=[]
          let err
          if(!error){
            items= results
          }else{
            err =error.code
          }
          res.jsonp({items,err, lidinfo:lidinfo[lididx]})
        })
      }else{
        res.jsonp({items:[], err:'you are not authorized for this list'})
      }
    }
  })

  router.get('/item/:lid/:qry', bearerToken, function(req,res){
    if(!req.userTok.auth){
      var mess={message: 'in get /s2g/item/list/qry (not authoried)-'+req.userTok.message}
      res.jsonp(mess)
    }else{
      const {lid, qry }= req.params
      let qph = `%${qry}%`
      var q =conn.query('SELECT * FROM items WHERE lid=? AND product like(?) AND done=1;', [lid,qph] , function(error, results){
        const items= results
        res.jsonp(items)
      })
    }
  })

  router.get('/stores/:lid', bearerToken, function(req,res){
    if(!req.userTok.auth){
      var mess={message: 'in get /s2g/stores (not authoried)-'+req.userTok.message}
      cons.log(mess)
      res.jsonp({err:mess})
    }else{
      const {lid}=req.params
      console.log('req.userTok: ', req.userTok)
      const qry = conn.query('SELECT * FROM stores WHERE lid =? ORDER BY store,idx; SELECT DISTINCT loc FROM stores WHERE lid=? ORDER BY loc;',[lid,lid], (err,results)=>{
        console.log('qry.sql: ', qry.sql)
        console.log('results: ', results)
        res.jsonp({stores:results[0], locs:results[1]})
      })
      
    }
  })

  return router
}