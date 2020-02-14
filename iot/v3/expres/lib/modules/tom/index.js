var express = require('express');
var cons = require('tracer').console();
var conn = require('../../db/mysqldb')
var bearerTokenApp = require('../regtokau/strategy').bearerTokenApp
var cfg = require('../../utilities').cfg
var Reco = require('../../db/models').Reco

var router = express.Router();

module.exports = function() {
  router.get('/', function(req, res) {
    res.jsonp({message: "in root of tom module"})
  });
  router.get('/amts', function(req,res){
    console.log('in /tom/amts no params')
    var q =conn.query('SELECT num FROM heirlooms',  function(error, results){
      console.log(q.sql)
      var arrres = results.map((dev)=>dev.num)
      res.jsonp(arrres)
    })
  })
  router.post('/pst', function(req,res){
    var pdata=req.body
    console.log(pdata)
    let csel = JSON.parse(pdata.selected)
    console.log('csel: ', csel[1])
    var query = conn.query('INSERT INTO hepeop SET ? ON DUPLICATE KEY UPDATE ?; SELECT selected FROM hepeop; SELECT variety, dot FROM heirlooms;', [pdata,pdata], function(error,results){
      console.log(query.sql)
      if (error) {
        throw error;
        console.log({message: error})
      }else{
        let conres = results[2].map((b)=>{
          let c ={...b}
          c.num=0
          return c
        })
        console.log('conres: ', conres)
        console.log(results[1].selected)
        const resu = results[1].map((r)=>{
          return JSON.parse(r.selected)
        })
        console.log('resu: ', resu)
        //let conres = []
        resu.map((m)=>{
          conres=conres.concat(m)
        })
        console.log('conres: ', conres)
        const sorres =conres.sort((a,b)=>a.variety < b.variety ? -1 :1)
        console.log('sorres: ', sorres)
        const redres = sorres.reduce((acc, obj)=>{
          const len=acc.length
          obj.num=obj.num*1
          if(obj.variety==acc[len-1].variety){
            console.log('obj.variety: ', obj.variety)
            acc[len-1].num += obj.num
          }else{
            acc.push(obj)
          }
          return acc
        },[{variety:'ulysses'}])
        console.log('redres: ', redres)
        redres.map((r)=>{
          var query = conn.query('UPDATE heirlooms set num = amt - ? WHERE variety=?', [r.num, r.variety], function(error,results){
            console.log('query.sql: ', query.sql)
          })
        })
      }
      res.jsonp({message:'hello'})
    })
  })
  router.get('/list/:who', (req,res)=>{
    let email = req.params.who
    const qry= conn.query('SELECT selected FROM hepeop WHERE name=?', email, (err,resu)=>{
      console.log('qry.sql: ', qry.sql)
      console.log('err: ', err)
      res.jsonp({results:resu[0]})
    })
  })
    // router.post('/pstold', function(req,res){
    //   var pdata=req.body
    //   console.log(pdata)
    //   let csel = JSON.parse(pdata.selected)
    //   let reserve = csel.selected
    //   let ids= []
    //   let pids =[]
    //   console.log('csel: ', csel[1])
    //   csel.map((d,i)=>{
    //     if (d==1){
    //       ids.push(i+1)
    //     }
    //   })
    //   cons.log(ids)
    //   var query2 = conn.query('SELECT selected FROM hepeop WHERE name= ?', pdata.name, function(error,results,fields){
    //     cons.log(query2.sql)
    //     var arrres = results.map((dev)=>dev.selected)
    //     var query = conn.query('INSERT INTO hepeop SET ? ON DUPLICATE KEY UPDATE ?', [pdata,pdata], function(error,results,fields){
    //         console.log(query.sql)
    //         if (error) {
    //           throw error;
    //           console.log({message: error})
    //         }else{
    //           console.log(results)
    //         }
    //         var query4 = conn.query('UPDATE heirlooms SET amt = amt - 1 WHERE id IN ( ? )', [ids], function(error,results,fields){
    //           cons.log(query4.sql)
    //           if (arrres[0]){
    //             let prarr = JSON.parse(arrres[0])
    //             prarr.map((p,i)=>{
    //               if(p==1){
    //                 pids.push(i+1)
    //               }
    //             })
    //             cons.log(pids)
    //             var query3 = conn.query('UPDATE heirlooms SET amt = amt +1 WHERE id IN ( ? )', [pids], function(error,results,fields){
    //               cons.log(query3.sql)
    //               res.jsonp({message:'hello'})
    //             })
    //           }else{
    //             res.jsonp({message:'hello'})
    //           }				  			
    //         })						
    //     })		  
    //   })
  // })
  return router
}