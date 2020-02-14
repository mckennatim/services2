//var moment = require('moment');
var env = require('../../env.json')
console.log('env: ', env)
var cfg= env[process.env.NODE_ENV||'development']
var mysql = require('mysql');
var mconn = cfg.mysql;
const conn = mysql.createConnection(mconn);

const tbarr = [`bids`, `co`, `cosr`, `gl`, `jobcatact`, `persons`, `rolewho`, `tcardjc`, `tcardpu`, `tcardwk` ]

tbarr.map((t)=>{
  conn.query("DESCRIBE `demo`.`"+t+"`;", (err,res)=>{
    const fnames = res
    .filter((e)=>e.Field!='id')
    .map((f)=>f.Field)
    console.log('fnames: ', fnames)
    const bq = conn.query("INSERT INTO `timecards`.`"+t+"` ("+fnames+") SELECT "+fnames+" FROM `demo`.`"+t+"`", (err2, res2)=>{
      console.log('bq.sql: ', bq.sql)
      console.log('err2: ', err2)
      console.log('res2: ', res2)
    })
  })
})


