var mysql      = require('mysql');
var jwt = require('jwt-simple');
var cons = require('tracer').console();
var ut = require('./utility')
var env = require('./env.json')
var cfg= env[process.env.NODE_ENV||'development']
console.log(cfg.mysql)
var conn = mysql.createConnection(cfg.mysql);

//cons.log(ut.cfg)

const dbAuth = (client, username,password, cb)=>{
  console.log(client.id, username, password)
  if(client.id.substr(0,2)=="CY"){
    console.log('is a device')
    var query=conn.query("SELECT devid, devpwd, owner FROM devs WHERE devid=?", client.id, function(error,results){
      cons.log(query.sql)
      cons.log(results)
      cons.log(error)
      if(error){
        cb(false)
      }else {
        var res = results[0];
        if(ut.get('res.devid',res)==client.id && ut.get('res.owner',res)==username && ut.get('res.devpwd',res)==password){
          cb(true)
        } else {
          cb(false)
        }
      }
    })
  }else{
    cons.log('is a client')
    var clientid= client.id.split('0.')[0]
    if(username=='anybody'){
      cons.log('ck if anybody is allowed')
      var query2 = conn.query("SELECT role FROM geniot.app_loc_user WHERE appid=? AND userid='anybody' AND locid='anywhere' AND auth=1",clientid , function(error2,results2){
        cons.log(query2.sql)
        console.log(results2)
        console.log('error2: ', error2)
        if(results2[0] ){
          cons.log('anybody is allowed')
          cb(true)
        }else{
          cons.log('anybody is not allowed')
          cb(false)
        }
      })
    }else if(password){
      var tokdata = jwt.decode(password, cfg.secret)
      cons.log(clientid)
      cons.log(username)
      cons.log(tokdata)
      if(tokdata.app==clientid  && tokdata.email==username){
        cons.log('should be true')
        client.appId= tokdata.appId
        cons.log(client.appId)
        cb(true)
      }else{
        cb(false)
      }
    }else{
      cb(false)
    }
  }
}


const dbSubscr=(password, cb)=>{
  const tokdata = jwt.decode(password, cfg.secret)
  if(tokdata.email==cfg.super){
    console.log('is super')
    cb(true)
    return
  }
  console.log('tokdata: ', tokdata)
  cons.log(tokdata)
  var query = conn.query("SELECT auth FROM app_loc_user WHERE appid=? AND userid=? AND locid=? AND auth=1",[tokdata.app, tokdata.email, tokdata.loc] , function(error,results){
    cons.log(query.sql)
    //cons.log(results[0])
    var cbv=false
    if(error){
      cbv= false
    }else {
      if(results.length>0){
        cbv=true
      } else {
        cbv=false
      }
    }
    cb(cbv)    
  })
}

const dbPublish=(password, cb)=>{
  const tokdata = jwt.decode(password, cfg.secret)
  if(tokdata.email==cfg.super){
    cb(true)
    return
  }
  var query = conn.query("SELECT role FROM app_loc_user WHERE appid=? AND userid=? AND locid=? AND auth=1",[tokdata.app, tokdata.email, tokdata.loc] , function(error,results){
    cons.log(query.sql)
    console.log('results: ', results)
    var cbv=false
    if(error){
      cbv=false
    }else if(results.length>0) {
      var res = results[0];
      cons.log(res)
      if(ut.get('res.role',res)=='obs'){
        cbv=false
      } else {
        cbv=true
      }
    }
    cb(cbv)
  })
}


const dbPubSet=(password,cb)=>{
  const tokdata = jwt.decode(password, cfg.secret)
  if(tokdata.email==cfg.super){
    console.log('is super')
    cb(true)
    return
  }
  var query = conn.query("SELECT role FROM app_loc_user WHERE appid=? AND userid=? AND locid=? AND role='admin'",[tokdata.app, tokdata.email, tokdata.loc] , function(error,results){
    console.log('query.sql: ', query.sql)
    if(error){
      cb(false)
    }else {
      cons.log(results)
      if(results.length>0){
        cb(true)
      }else{
        cb(false)
      }
    }
  })
}

const dbGetTimezone=(devId, cb)=>{
  var query=conn.query("SELECT l.timezone FROM locations l, devs d WHERE l.locid=d.locid AND d.devid=?", devId, function(error,results){
    console.log('query.sql: ', query.sql)
    cb(results[0].timezone)
  })
}

  /*
  first there is the inner query which groups by senrel taking only the max dow which eliminates dow=0 values when there is a record for the actual dow. The inner join is used to filter all the records to just take that.
  SELECT * FROM scheds a
  INNER JOIN (SELECT MAX(dow)as mdow, senrel 
    FROM scheds
    WHERE devid='CYURD002' AND (dow=2 OR dow=0) 
    GROUP BY senrel)b
  ON a.dow=b.mdow AND a.senrel=b.senrel

  SELECT * FROM scheds a INNER JOIN (SELECT MAX(dow)as mdow, senrel FROM scheds WHERE devid=? AND (dow=? OR dow=0) GROUP BY senrel)b ON a.dow=b.mdow AND a.senrel=b.senrel
  */
  //var query=conn.query("SELECT * FROM scheds WHERE devid=? AND (dow=? OR dow=0) ORDER BY dow", [devid,dow], function(error,results,fields){
const getTodaysSched=(devid, timeobj, cb)=>{
  let dow = timeobj.dow
  let myuntil = timeobj.mysql.split(' ')[0]
  var query=conn.query("SELECT * FROM scheds WHERE (devid,senrel,dow) IN ( SELECT devid, senrel, MAX(dow) FROM scheds WHERE (dow=0 OR dow & POW(2,?-1) OR dow>=128) AND (until = '0000-00-00' OR ? <= until) GROUP BY devid, senrel ) AND devid = ?", [dow,myuntil,devid], function(error,results){
    cons.log(query.sql)
    cons.log(results)
    cb(results)
  })
}

const getSenRelSched=(devid,senrel,dow,cb)=>{
  var query=conn.query("SELECT * FROM scheds WHERE devid= ? AND senrel=? AND (dow=0 OR dow=?) ORDER BY dow DESC LIMIT 0,1 ", [devid, senrel, dow], function(error,results){
    cons.log(query.sql)
    cons.log(results)
    cb(results)
  })
}

const add2bigdata =(rec)=>{
  var query=conn.query("INSERT INTO bigdata SET ?", rec, function(error,results){
    cons.log(query.sql)
  })  
}

module.exports = {
  cfg: cfg,
  conn: conn,
  dbAuth: dbAuth,
  dbSubscr: dbSubscr,
  dbPublish: dbPublish,
  dbPubSet: dbPubSet,
  dbGetTimezone: dbGetTimezone,
  getTodaysSched: getTodaysSched,
  getSenRelSched: getSenRelSched,
  add2bigdata
}