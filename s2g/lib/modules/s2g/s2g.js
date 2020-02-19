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
      res.jsonp(mess)
    }else{
      cons.log(req.userTok);
      var q =conn.query('SELECT * FROM users WHERE email=?;', req.userTok.emailId , function(error, results){
        cons.log(q.sql)
        console.log('results: ', results)
        const lists= JSON.parse(results[0].lids)
        console.log('lists: ', lists)
        res.jsonp(lists)
      })
    }
  })

  router.get('/items/:lid', bearerToken, function(req,res){
    if(!req.userTok.auth){
      var mess={message: 'in get /s2g/lists (not authoried)-'+req.userTok.message}
      cons.log(mess)
      res.jsonp(mess)
    }else{
      const lid = req.params.lid
      cons.log(req.userTok);
      var q =conn.query('SELECT * FROM items WHERE lid=? AND done=0;', lid , function(error, results){
        cons.log(q.sql)
        console.log('results: ', results)
        const items= results
        console.log('items: ', items)
        res.jsonp(items)
      })
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