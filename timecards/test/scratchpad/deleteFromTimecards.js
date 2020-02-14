//var moment = require('moment');
var env = require('../../env.json')
console.log('env: ', env)
var cfg= env[process.env.NODE_ENV||'development']
var mysql = require('mysql');
var mconn = cfg.mysql;
const conn = mysql.createConnection(mconn);


const delarr=  [ 'demo00' ]
const tbarr = [`bids`, `co`, `cosr`, `gl`, `jobcatact`, `persons`, `rolewho`, `tcardjc`, `tcardpu`, `tcardwk` ]
delarr.map((d)=>{
  tbarr.map((t,)=>{
    console.log('t: ', t)
    const aq2 = conn.query("DELETE FROM `timecards`.`"+t+"` WHERE coid = ?", d, function(err2, result2){
      console.log('result2: ', result2)
      console.log('aq.sql2: ', aq2.sql)
      console.log('err2: ', err2) 
    }) 
  })
})
