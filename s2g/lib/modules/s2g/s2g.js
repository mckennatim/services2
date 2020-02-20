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
      cons.log(req.userTok);
      var q =conn.query('SELECT * FROM users WHERE email=?;', req.userTok.emailId , function(error, results){
        cons.log(q.sql)
        console.log('results: ', results)
        let lists =[]
        let err
        if(!error){
          lists= JSON.parse(results[0].lids)
          console.log('lists: ', lists)
        }else{
          err =error.code
        }
        res.jsonp({lists,err})
      })
    }
  })

  router.get('/items/:lid', bearerToken, function(req,res){
    if(!req.userTok.auth){
      var mess={message: 'in get /s2g/lists (not authoried)-'+req.userTok.message}
      cons.log(mess)
      res.jsonp({err:mess})
    }else{
      const lid = req.params.lid
      cons.log(req.userTok);
      const lidinfo = JSON.parse(req.userTok.lids)
      const lididx = lidinfo.findIndex((l)=>l.lid==lid)
      console.log('lididx, lidinfo: ', lididx, lidinfo)
      if(lididx > -1){
        var q =conn.query('SELECT * FROM items WHERE lid=? AND done=0;', lid , function(error, results){
          cons.log(q.sql)
          console.log('results: ', results)
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
      cons.log(mess)
      res.jsonp(mess)
    }else{
      const {lid, qry }= req.params
      let qph = `%${qry}%`
      cons.log(req.userTok);
      var q =conn.query('SELECT * FROM items WHERE lid=? AND product like(?) AND done=1;', [lid,qph] , function(error, results){
        cons.log(q.sql)
        console.log('results: ', results)
        const items= results
        console.log('items: ', items)
        res.jsonp(items)
      })
    }
  })

  return router
}