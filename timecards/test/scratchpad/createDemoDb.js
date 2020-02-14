const mysqldump = require('mysqldump')
var moment = require('moment');
var env = require('../../env.json')
console.log('env: ', env)
var cfg= env[process.env.NODE_ENV||'development']
var mysql = require('mysql');
var mconn = cfg.mysql;
const conn = mysql.createConnection(mconn);

const newdb = 'demo'
const coid = 'reroo'
const tbarr = [`bids`, `co`, `cosr`, `gl`, `jobcatact`, `persons`, `rolewho`, `tcardjc`, `tcardpu`, `tcardwk` ]
//const bkarr = [`bids`, `co`, `cosr`, `gl`, `jobcatact`, `persons`, `rolewho`,]
const arrlen=tbarr.length
// const tbl = `${db}.${tb}`
const aq = conn.query("CREATE DATABASE IF NOT EXISTS `"+ newdb +"`; SELECT goodtil, coid FROM timecards.co WHERE coid LIKE 'demo%' ORDER BY coid;", function(err, res){
  const resarr = res[1]
  console.log('aq.sql: ', aq.sql)
  console.log('err: ', err)
  const delarr =resarr
  .filter((d)=>moment(d.goodtil)<moment())
  .map((d)=>d.coid)
  console.log('delarr: ', delarr)
  const arr= res[1]
  .filter((a)=>moment(a.goodtil)>=moment())
  .map((r)=>r.coid.slice(4)*1)

  let slot = -1
  for(var i = 0; i< arr.length; i++){
    if(i+1==arr.length){
      slot= arr[i]+1
      break;
    }
    if(arr[i]-slot>1){
      slot = slot+1
      break;
    }else {
      slot = arr[i]
    }
  }
  const ncoid = 'demo'+slot.toString().padStart(2,'0')
  /*copy from timecards to demo change coid to slot*/
  tbarr.map((t,i)=>{
    console.log('t: ', t)
    const aq2 = conn.query("DROP TABLE IF EXISTS `"+newdb+"`.`"+t+"`; CREATE TABLE `"+newdb+"`.`"+t+"` SELECT * FROM `timecards`.`"+t+"` WHERE coid=?; UPDATE `"+newdb+"`.`"+t+"` SET coid= ? WHERE coid = ? ", [coid, ncoid, coid], function(err2, result2){
      console.log('result2: ', result2)
      console.log('aq.sql2: ', aq2.sql)
      console.log('err2: ', err2) 
      if(i+1==arrlen){
        mconn.database = newdb
        mysqldump({
          connection: mconn,
          dumpToFile: `./${newdb}.sql`,
        })  
      }      
    }) 
  })
})