var moment = require('moment');
var env = require('../../env.json')
console.log('env: ', env)
var cfg= env[process.env.NODE_ENV||'development']
var mysql = require('mysql');
var mconn = cfg.mysql;
const conn = mysql.createConnection(mconn);

const aq = conn.query("SELECT goodtil, coid FROM timecards.co WHERE coid LIKE 'tim%' ORDER BY coid;",(err,res)=>{
  console.log('err: ', err)
  console.log('res: ', res)
  const delarr = res
  .filter((d)=>moment(d.goodtil)<moment())
  .map((d)=>d.coid)
  
  console.log('delarr: ', delarr)
  
  const arr= res
  .filter((a)=>moment(a.goodtil)>=moment())
  .map((r)=>{
    console.log('r.goodtil: ', r.goodtil, r.coid)
    return r.coid.slice(3,4)*1
  });
  
  let slot = -1;
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

  const are = conn.query("SELECT * FROM ssaRE;", (err, res)=>{
    console.log('are.sql: ', are.sql)
    console.log('err: ', err)
    console.log('res: ', res)  
  })
  console.log('slot: ', 'demo'+slot.toString().padStart(2,'0'))
  console.log('arr: ', arr)
  console.log('aq.sql: ', aq.sql)
  
})