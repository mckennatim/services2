var moment = require('moment-timezone');
const fs = require('fs');
var nodemailer = require('nodemailer')
let mysqldump = require('mysqldump')
// let sql2js = require("./sql-to-csv.js")
var cons = require('tracer').console();
var env = require('../../../env.json')
//cons.log('env: ', env)
var cfg= env[process.env.NODE_ENV||'development']
var mysql = require('mysql');
var mconn = cfg.mysql;
const conn = mysql.createConnection(mconn);

const tbarr = [`bids`, `co`, `cosr`, `gl`, `jobcatact`, `persons`, `rolewho`, `tcardjc`, `tcardpu`, `tcardwk`, `paystubs` ]
const arrlen=tbarr.length
const bkarr = [`bids`, `co`, `cosr`, `gl`, `jobcatact`, `persons`, `rolewho`,]
//let goodtil=''

const getNcoidAndDelarr = (cb)=>{
  // const newdb = 'demo'
  // const coid = 'reroo'
  const aq = conn.query("SELECT goodtil, coid FROM timecards.co WHERE coid LIKE 'demo%' ORDER BY coid;", function(err, res){
    const resarr = res
    cons.log('aq.sql: ', aq.sql)
    const delarr =resarr
      .filter((d)=>moment(d.goodtil)<moment())
      .map((d)=>d.coid)
    cons.log('delarr: ', delarr)
    const arr= res
      .filter((a)=>{
        console.log(moment().format('YYYY-MM-DD hh:mm:ss'))
        console.log(moment(a.goodtil).format('YYYY-MM-DD hh:mm:ss'))
        return moment(a.goodtil)>=moment()
      })
      .map((r)=>r.coid.slice(4)*1)
    let slot = 0
    for(var i = 0; i< arr.length; i++){
      if(i+1==arr.length){
        slot= arr[i]+1
        console.log('arr[i]+1: ', arr[i]+1)
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
    cb(delarr, ncoid)
  })
}

const deleteExpiredDemos = (delarr, cb)=>{
  console.log(delarr)
  if(delarr.length>0){
    delarr.map((d)=>{
      console.log('IN DELARR MAP')
      tbarr.map((t,i)=>{
        cons.log('t: ', t)
        const aq2 = conn.query("DELETE FROM `timecards`.`"+t+"` WHERE coid = ?", d, function(err2, result2){
          cons.log('result2: ', result2)
          cons.log('aq.sql2: ', aq2.sql)
          cons.log('err2: ', err2) 
          if(i+1==arrlen){
            cb()
          }
        }) 
      })
    })  
  }else{
    cb()
  }
}

const createDemoDb = (ncoid, cb)=>{
  const newdb = 'demo'
  const coid = 'reroo'
  conn.query("CREATE DATABASE IF NOT EXISTS `"+ newdb +"`; ", function(){
    tbarr.map((t,i)=>{
      console.log('t: ', t)
      const aq2 = conn.query("DROP TABLE IF EXISTS `"+newdb+"`.`"+t+"`; CREATE TABLE `"+newdb+"`.`"+t+"` SELECT * FROM `timecards`.`"+t+"` WHERE coid=?; UPDATE `"+newdb+"`.`"+t+"` SET coid= ? WHERE coid = ? ", [coid, ncoid, coid], function(err2, result2){
        cons.log('result2: ', result2)
        cons.log('aq.sql2: ', aq2.sql)
        cons.log('err2: ', err2) 
        if(i+1==arrlen){
          cb()
        }
      }) 
    })  
  })
}

const createBkDb =(ncoid, cb)=>{
  conn.query("CREATE DATABASE IF NOT EXISTS `"+ ncoid +"`; ", function(){
    bkarr.map((t,i)=>{
      console.log('t: ', t)
      const aq2 = conn.query("\
        DROP TABLE IF EXISTS `"+ncoid+"`.`"+t+"`;\
        CREATE TABLE `"+ncoid+"`.`"+t+"` SELECT * FROM `timecards`.`"+t+"` WHERE coid=?;", 
        ncoid, function(err2, result2){
        cons.log('result2: ', result2)
        cons.log('aq.sql2: ', aq2.sql)
        cons.log('err2: ', err2) 
        console.log('i: ', i)
        console.log('bkarr.length: ', bkarr.length)
        if(i+1==bkarr.length){
          console.log('starting mysqldump')
          mconn.database = ncoid
          const dres = mysqldump({
            connection: mconn,
            dumpToFile: `./${ncoid}.sql`
          })
          dres.then(()=>{
            cb()
          })
        }
      }) 
    })  
  })
} 

const copyFromDemoDb=(cb)=>{
  console.log('IN COPY FROM DEMO DEB')
  tbarr
  .map((t,i)=>{
    conn.query("DESCRIBE `demo`.`"+t+"`;", (err,res)=>{
      const fnames = res
      .filter((e)=>e.Field!='id')
      .map((f)=>`\`${f.Field}\``)
      cons.log('fnames: ', fnames)
      const bq = conn.query("INSERT INTO `timecards`.`"+t+"` ("+fnames+") SELECT "+fnames+" FROM `demo`.`"+t+"`", (err2, res2)=>{
        cons.log('bq.sql: ', bq.sql)
        cons.log('err2: ', err2)
        cons.log('res2: ', res2)
        if(i+1==arrlen){
          cb()
        }
      })
    })
  }) 
}

const addPartner2DemoXX = (ncoid, emailid, min, cb)=>{
  /*indexes
  rolewho  ->rec: emailid,coid
  persons -> ece: emailid,coid,effective
  */ 
  const goodtil = moment().add(min, 'm').format('YYYY-MM-DD HH:mm:ss')
  console.log('goodtil: ', goodtil)
  const effective = moment().format('YYYY-MM-DD')
  console.log('effective: ', effective)
  const goodobj = {goodtil: goodtil}
  const roleobj ={role:'partner', emailid:emailid, coid:ncoid, active:1}
  const perobj ={wtype:'partner', emailid:emailid, coid:ncoid, effective:effective}
  var query2 = conn.query("\
    UPDATE `timecards`.`co` SET ? WHERE coid=?;\
    INSERT INTO `timecards`.`rolewho` SET ? ON DUPLICATE KEY UPDATE ?;\
    INSERT INTO `timecards`.`persons` SET ? ON DUPLICATE KEY UPDATE ?;"
    ,[
      goodobj, ncoid, 
      roleobj, roleobj,
      perobj, perobj
    ] , function(error2, result) {
      cons.log(query2.sql) 
      cons.log(error2)
      cons.log(result)
      cb(ncoid,goodtil)
  })
}

const delCoidsLike=(like,cb)=>{
  tbarr.map((t,i)=>{
    console.log('t: ', t)
    const aq2 = conn.query("DELETE FROM `timecards`.`"+t+"` WHERE coid LIKE ?", like, function(err2, result2){
      console.log('result2: ', result2)
      console.log('aq.sql2: ', aq2.sql)
      console.log('err2: ', err2) 
      if(i+1==arrlen){
        cb()
      }
    }) 
  })
}

const emailBkup=(email, coid ,cb)=>{
  let smtpTransport = nodemailer.createTransport({
    service: 'gmail',
    auth: cfg.gmail.auth
  }); 
  var message = {
    from: "Timecards.sitebuilt.net <mckenna.tim@gmail.com>", // sender address
    to: email, // list of receivers
    subject: `${coid} backup data file`, // Subject line
    text: `Attached please find your backup data file for coid: ${coid} `, // plaintext body
    html:`Attached please find your backup data file for coid: ${coid} ` ,// html body
    attachments:[
      {
        filename: `${coid}.sql`,
        path: `./${coid}.sql`
      }
    ]
  }
  smtpTransport.sendMail(message, (error, response)=>{
    let ret
    if(error){
      console.log(error);
      ret = error;
    }else{
      console.log("Message sent: " + response.message);
      ret = {message: 'check your email and come back'} 
    }
    smtpTransport.close(); // shut down the connection pool, no more messages
    console.log(ret)
    cb(ret);
  });   
}

const unlinkBkup=(filewpath,cb)=>{
  fs.unlink(filewpath, (err) => {
    if (err) throw err;
    console.log(`successfully deleted ${filewpath}`);
    cb(`successfully deleted ${filewpath}`);
  });
}

const startDemo = (emailid , min, cb)=>{
  getNcoidAndDelarr((delarr, ncoid)=>
  deleteExpiredDemos(delarr, ()=>
  createDemoDb(ncoid, ()=>
  copyFromDemoDb(()=>
  addPartner2DemoXX (ncoid, emailid, min, (ncoid, goodtil)=>cb(ncoid, goodtil))))))
}

module.exports = { getNcoidAndDelarr, createDemoDb, createBkDb, copyFromDemoDb, delCoidsLike, deleteExpiredDemos, addPartner2DemoXX, startDemo, emailBkup, unlinkBkup }