var express = require('express');
// var cons = require('tracer').console();
// var conn = require('../../db/mysqldb')
// var bearerTokenAppLoc = require('../regtokau/strategy').bearerTokenAppLoc

var router = express.Router();

module.exports = function() {
  router.get('/', (req, res)=>{
    res.jsonp({message: "in root of signin module"})
  })
  return router
}
