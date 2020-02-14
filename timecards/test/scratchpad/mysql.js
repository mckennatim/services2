var mysql      = require('mysql');
var env = require('../../env.json')
var cfg= env[process.env.NODE_ENV||'development']

var conn = mysql.createConnection(cfg.mysql);

//------------holds----------------------------

var bdata={
  devid:'CYURD003', 
  senrel: 0,
  until: '2018-02-11 00:00',
  sched: '[[0,0,74,72]]'
}

var query2 = conn.query('INSERT INTO holds SET ? ON DUPLICATE KEY UPDATE ?', [bdata,bdata], function(error,results,fields){
    console.log(query2.sql)
    if (error) {
      throw error;
      console.log({message: error})
    }else{
      console.log(results)
    }
    //process.exit()
})

var until =['CYURD001', 1, '2018-02-10 00:00']

var query2 = conn.query('SELECT sched FROM holds WHERE devid=? AND senrel=? AND until> ?', until, function(error,results,fields){
    console.log(query2.sql)
    if (error) {
      throw error;
      console.log({message: error})
    }else{
      console.log(results[0].sched)
    }
    
})

var pdata={ devid: 'CYURD001', dow: 6, senrel: 1, sched: '[[12,20,77,75]]' }

var query = conn.query('INSERT INTO scheds SET ? ON DUPLICATE KEY UPDATE ?', [pdata,pdata], function(error,results,fields){
        console.log(query.sql)
        console.log(error)
        console.log(results)
        process.exit()
      })