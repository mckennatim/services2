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
        const lids = JSON.parse(results[0].lids)
        console.log('lids: ', lids)
        res.jsonp({results:lids})
      })
    }
  })
  return router
}