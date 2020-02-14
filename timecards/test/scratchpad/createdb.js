const mysqldump = require('mysqldump')

var env = require('../../env.json')
console.log('env: ', env)
var cfg= env[process.env.NODE_ENV||'development']
var mysql = require('mysql');
var mconn = cfg.mysql;


const conn = mysql.createConnection(mconn);
const newdb = 'demo'
const coid = 'reroo'
let curdb = newdb
const db = `\`${curdb}\``
const tbarr = [`bids`, `co`, `cosr`, `gl`, `jobcatact`, `persons`, `rolewho`, `tcardjc`, `tcardpu`, `tcardwk` ]
//const bkarr = [`bids`, `co`, `cosr`, `gl`, `jobcatact`, `persons`, `rolewho`,]
const arrlen=tbarr.length
// const tbl = `${db}.${tb}`
const aq = conn.query("CREATE DATABASE IF NOT EXISTS `"+ newdb +"`; ", function(err, result){
  console.log('result: ', result)
  console.log('aq.sql: ', aq.sql)
  console.log('err: ', err)
  tbarr.map((t,i)=>{
    console.log('t: ', t)
    const aq2 = conn.query("DROP TABLE IF EXISTS "+`${db}.\`${t}\``+"; CREATE TABLE "+`${db}.\`${t}\``+" SELECT * FROM `timecards`.`"+t+"` WHERE coid=?;", coid, function(err2, result2){
      console.log('result2: ', result2)
      console.log('aq.sql2: ', aq2.sql)
      console.log('err2: ', err2) 
      if(i+1==arrlen){
        mconn.database = curdb
        mysqldump({
          connection: mconn,
          dumpToFile: `./${curdb}.sql`,
        })  
      }      
    }) 
  })
})