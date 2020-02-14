var express = require('express');
var router = express.Router();
var cons = require('tracer').console();
var moment = require('moment');
var conn = require('../../db/mysqldb')
// var combinePuJc = require('../../utilities').combinePuJc
var bearerTokenCoid = require('../regtokau/strategy').bearerTokenCoid
var JSZip = require("jszip");
var fs = require("fs");
function addAppId(req,res,next){
  req.appid = 'pay'
  next()
}

module.exports = function() {
  router.get('/', function(req, res) {
      res.jsonp({ message: "in root of payroll module" })
  });
  router.post('/jc', addAppId, bearerTokenCoid, function(req,res){
    if (!req.userTok.auth) {
      var mess = { message: 'in get /payroll/jc (not authorized)-' + req.userTok.message }
      res.jsonp(mess)
    } else {
      cons.log('req.userTok: ', req.userTok)
      const {jcrates} = req.body
      jcrates.ratearr.map((hrcost,i)=>{
        const wdprt = jcrates.wprt+'-'+(i+1)
        console.log('wdprt: ', wdprt)
        console.log('hrcost: ', hrcost)
        const seljc = conn.query('SELECT * FROM tcardjc WHERE emailid= ? AND wdprt = ? AND coid = ? ; UPDATE tcardwk SET status=? WHERE coid=? AND wprt=? AND emailid=?',[jcrates.emailid, wdprt, req.userTok.coid, 'paid', req.userTok.coid, jcrates.wprt, jcrates.emailid], function(error1, sesults){
          cons.log(seljc.sql)
          cons.log(error1)
          cons.log('results: ', sesults[0])
          sesults[0].map((s)=>{
            const cst = hrcost*s.hrs
            const updjc =conn.query("INSERT INTO gl (coid, account, wdprt, job,cat,date,someid,somenum,debit) VALUES (?, ?, ?, ?, ?, ?, ?, ?,?);  UPDATE tcardjc SET hrcost=?, cost=? WHERE id = ?; UPDATE gl SET account='a6000-labor' WHERE job = 'labor expense';",[s.coid, 'a5010-COGS', s.wdprt, s.job, s.cat, jcrates.paydate, s.emailid, s.hrs, cst, hrcost, cst, s.id], function(error, results){
              cons.log(updjc.sql)
              cons.log(error)
              cons.log('results: ', results)
            })
          })
        })
      })
      res.jsonp({binfo: req.userTok })  
    } 
  })

  router.post('/gl', addAppId, bearerTokenCoid, function(req,res){
    if (!req.userTok.auth) {
      var mess = { message: 'in get /payroll/gl (not authorized)-' + req.userTok.message }
      res.jsonp(mess)
    } else {
      cons.log('req.userTok: ', req.userTok)
      const {journal, paydate, emailid} = req.body
      cons.log(journal)
      const keys = Object.keys(req.body.journal[0]).join()+',coid'
      const vals = [req.body.journal.map((j) => {
        let anarr = Object.values(j)
        anarr.push(req.userTok.coid)
        return anarr
      })]
      // const emailid = vals[0][2]
      // const pdate = vals[0][5]
      // cons.log('keys: ', keys)
      var query = conn.query('INSERT INTO gl (' + keys + ') VALUES ? ', vals, function(error, results) {
          cons.log(query.sql)
          cons.log(error)
          cons.log(results)
          // const qtrba = conn.query('SELECT SUM(debit) as debit, SUM(credit) as credit FROM gl WHERE coid =?',req.userTok.coid, function(errtrba, restrba){
          const qtrba = conn.query("SELECT someid, `date`, SUM(debit) as debit, SUM(credit) as credit FROM gl WHERE `date`=? AND  someid=? AND coid = ? GROUP BY someid, `date` ",[paydate, emailid, req.userTok.coid], function(errtrba, restrba){
            cons.log(qtrba.sql)
            cons.log(errtrba)
            cons.log(restrba)
            cons.log(mess)
            //res.jsonp({errtrba:errtrba, tribal: restrba, error:error, keys:keys, emailid:emailid, paydate:paydate})
            res.jsonp({errtrba:errtrba, tribal: restrba, error:error, paydate:paydate, emailid:emailid})
          })
      })
    }
  })
  router.post('/payment', addAppId, bearerTokenCoid, function(req,res){
    if (!req.userTok.auth) {
      var mess = { message: 'in get /payroll/payment (not authorized)-' + req.userTok.message }
      res.jsonp(mess)
    } else {
      cons.log('req.userTok: ', req.userTok)
      const {journal} = req.body
      cons.log(journal)
      const keys = Object.keys(req.body.journal[0]).join()+',coid'
      const vals = [req.body.journal.map((j) => {
        let anarr = Object.values(j)
        anarr.push(req.userTok.coid)
        return anarr
      })]
      var query = conn.query('INSERT INTO gl (' + keys + ') VALUES ? ', vals, function(error, results) {
          cons.log(query.sql)
          cons.log(error)
          cons.log(results)
          res.jsonp({results, error})
      })
    }
  })

  router.post('/stub', addAppId, bearerTokenCoid, function(req,res){
    if (!req.userTok.auth) {
      var mess = { message: 'in get /payroll/paystub (not authorized)-' + req.userTok.message }
      res.jsonp(mess)
    } else {
      cons.log('req.userTok: ', req.userTok)
      const {paystub} = req.body
      cons.log(paystub)
      var query = conn.query('INSERT INTO paystubs SET ? ', paystub, function(error, results) {
          cons.log(query.sql)
          cons.log(error)
          cons.log(results)
          res.jsonp({results, error})
      })
    }
  })

  router.get('/stubs', addAppId, bearerTokenCoid, function(req, res) {
    if (!req.userTok.auth) {
        var mess = { message: 'in get /payroll/stubs (not authorized)-' + req.userTok.message }
        cons.log(mess)
        res.jsonp(mess)
    } else {
        var query = conn.query('SELECT * FROM `timecards`.`paystubs` WHERE coid =? ORDER BY week DESC LIMIT 25 ', req.userTok.coid, function(error, payres) {
            cons.log(query.sql)
            cons.log(error)
            res.jsonp(payres)
        })

    }
})

  router.post('/payment', addAppId, bearerTokenCoid, function(req,res){
    if (!req.userTok.auth) {
      var mess = { message: 'in get /payroll/payment (not authorized)-' + req.userTok.message }
      res.jsonp(mess)
    } else {
      cons.log('req.userTok: ', req.userTok)
      const {journal} = req.body
      cons.log(journal)
      const keys = Object.keys(req.body.journal[0]).join()+',coid'
      const vals = [req.body.journal.map((j) => {
        let anarr = Object.values(j)
        anarr.push(req.userTok.coid)
        return anarr
      })]
      var query = conn.query('INSERT INTO gl (' + keys + ') VALUES ? ', vals, function(error, results) {
          cons.log(query.sql)
          cons.log(error)
          cons.log(results)
          res.jsonp({results, error})
      })
    }
  })  
  router.put('/bid', addAppId, bearerTokenCoid, function(req,res){
    if (!req.userTok.auth) {
      var mess = { message: 'in get /payroll/bid (not authorized)-' + req.userTok.message }
      res.jsonp(mess)
    } else {
      cons.log('req.userTok: ', req.userTok)
      const {bid} = req.body
      bid.coid =req.userTok.coid 
      var query = conn.query('INSERT INTO bids SET ? ON DUPLICATE KEY UPDATE ?', [bid, bid], function(error, results) {
        cons.log('query.sql: ', query.sql)
        cons.log(bid)
        res.jsonp({bid, results})
      })
    }
  })
  // router.post('/ckcoid', bearerTokenApp, function(req,res){
  //     if (!req.userTok.auth) {
  //       var mess = { message: 'in get /payroll/ckcoid (not authorized)-' + req.userTok.message }
  //       res.jsonp(mess)
  //     } else {
  //       cons.log('req.userTok: ', req.userTok)
  //       cons.log('req.body: ', req.body) 
  //       var query = conn.query('SELECT coid FROM `timecards`.`co` WHERE coid=?', req.body.co.coid, function(error, copman) {
  //           cons.log(query.sql)
  //           cons.log(error)
  //           if(copman.length>0){
  //             res.jsonp({message: 'coid already exists, try another' })
  //           }else{
  //             const goodtil = moment().add(30, 'days').format('YYYY-MM-DD')
  //             const effective = moment().format('YYYY-MM-DD')
  //             var query2 = conn.query("INSERT INTO `timecards`.`co` (goodtil, coid) VALUES(?,?); INSERT INTO `timecards`.`rolewho` (role, emailid, coid,active) VALUES('partner',?,?,1); INSERT INTO `timecards`.`journal` (emailid, coid, effective) VALUES(?,?,?); INSERT INTO `timecards`.`cosr` (coid, effective) VALUES(?,?); ", [goodtil, req.body.co.coid, req.body.co.emailid, req.body.co.coid, req.body.co.emailid, req.body.co.coid, effective, req.body.co.coid, effective], function(error2, result) {
  //               cons.log(query2.sql)
  //               cons.log(error2)
  //               cons.log(result)
  //               const exp = Math.floor(Date.now()) + addDays(40)
  //               cons.log('exp: ', exp)
  //               var payload = {
  //                 coid: req.body.co.coid,
  //                 role: 'partner',
  //                 appid: 'signup',
  //                 emailid: req.body.co.emailid,
  //                 exp: exp
  //               };
  //               var token = jwt.encode(payload, secret);
  //               res.jsonp({message: 'ok setting you up', goodtil:goodtil,result:result, token:token, emailid:req.body.co.emailid})
  //             })
  //           }
  //       })  
  //     }
  //   })

  router.get('/settings', addAppId, bearerTokenCoid, function(req, res) {
      if (!req.userTok.auth) {
          var mess = { message: 'in get /payroll/settings (not authorized)-' + req.userTok.message }
          cons.log(mess)
          res.jsonp(mess)
      } else {
          var query = conn.query('SELECT * FROM `timecards`.`cosr` WHERE effective <= CURDATE() AND coid =? ORDER BY effective DESC LIMIT 1 ', req.userTok.coid, function(error, settings) {
              cons.log(query.sql)
              cons.log(error)
              res.jsonp(settings)
          })

      }
  })
  router.get('/accrued', addAppId, bearerTokenCoid, function(req, res) {
    if (!req.userTok.auth) {
        var mess = { message: 'in get /payroll/accrued (not authorized)-' + req.userTok.message }
        cons.log(mess)
        res.jsonp(mess)
    } else {
        var query = conn.query("SELECT someid, account, SUM(somenum) as hrs, SUM(debit) as debit, SUM(credit) as credit FROM gl WHERE wdprt like(CONCAT(YEAR(CURDATE()),'%')) AND coid = ? GROUP BY someid,account", req.userTok.coid, function(error, accrued) {
            cons.log(query.sql)
            cons.log(error)
            res.jsonp(accrued)
        })
    }
  })  


  router.get('/bids', addAppId, bearerTokenCoid, function(req, res) {
    if (!req.userTok.auth) {
        var mess = { message: 'in get /payroll/bids (not authorized)-' + req.userTok.message }
        cons.log(mess)
        res.jsonp(mess)
    } else {
        var query = conn.query("SELECT job, labor FROM bids WHERE coid=?", req.userTok.coid, function(error, bids) {
            cons.log(query.sql)
            cons.log(error)
            res.jsonp(bids)
        })
    }
  }) 


  router.get('/rates', addAppId,  bearerTokenCoid, function(req, res) {
      if (!req.userTok.auth) {
          var mess = { message: 'in get /payroll/rates (not authorized)-' + req.userTok.message }
          cons.log(mess)
          res.jsonp(mess)
      } else {
          var query = conn.query('SELECT * FROM `timecards`.`co` WHERE coid=?', req.userTok.coid, function(error, cores) {
              cons.log(query.sql)
              cons.log(error)
              const st= cores[0].st
              const q2 = conn.query("SELECT * FROM `timecards`.`cosr` WHERE effective <= CURDATE() AND coid =? ORDER BY effective DESC LIMIT 1; SELECT * FROM `timecards`.`fedr` WHERE year = YEAR(CURDATE()); SELECT * FROM `timecards`.`fedwh` WHERE year = YEAR(CURDATE()); SELECT * FROM `timecards`.`strates` WHERE year = YEAR(CURDATE()) AND st= ?; ", [req.userTok.coid, st], (error2, rr)=>{
                  cons.log(q2.sql)
                  cons.log(error2)
                  res.jsonp({cosr: rr[0][0], fedr:rr[1][0], fedwh:rr[2], strates:rr[3][0]})
              })
          })
      }
  })

  router.get('/state/:st', addAppId, bearerTokenCoid, function(req, res) {
    if (!req.userTok.auth) {
      var mess = { message: 'in get payroll/state/:st (not authorized)-' + req.userTok.message }
      cons.log(mess)
      res.jsonp(mess)
    } else {
      const st =req.params.st
      var query = conn.query("SELECT * FROM `timecards`.`strates` WHERE year = YEAR(CURDATE()) AND st= ? ", st, function(error, results) {
        cons.log(query.sql)
        cons.log(error)
        res.jsonp(results)
      })
    }
  }) 
  // router.get('/submitted', bearerTokenCoid, function(req, res) {
  //     if (!req.userTok.auth) {
  //         var mess = { message: 'in get /payroll/submitted (not authorized)-' + req.userTok.message }
  //         cons.log(mess)
  //         res.jsonp(mess)
  //     } else {
  //         var query = conn.query('SELECT wprt, emailid, hrs, `status` FROM tcardwk WHERE status="submitted" AND coid=? ORDER BY wprt,emailid', req.userTok.coid, function(error, wstat) {
  //             cons.log(query.sql)
  //             cons.log(error)
  //             res.jsonp(wstat)
  //         })

  //     }
  // })
  router.get('/approved', addAppId, bearerTokenCoid, function(req, res) {
      if (!req.userTok.auth) {
          var mess = { message: 'in get /payroll/approved (not authorized)-' + req.userTok.message }
          cons.log(mess)
          res.jsonp(mess)
      } else {
          const coid = req.userTok.coid
          var query = conn.query("DROP TABLE IF EXISTS `timecards`.`cureff` ; CREATE TABLE `timecards`.`cureff` SELECT p.emailid , MAX(p.effective) AS curedate FROM `timecards`.`persons` p WHERE effective <= CURDATE() AND p.coid =? GROUP BY p.emailid; DROP TABLE IF EXISTS `timecards`.`cureffective` ; CREATE TABLE `timecards`.`cureffective` SELECT p.* FROM `timecards`.`cureff` c JOIN `timecards`.`persons` p ON c.emailid=p.emailid AND c.curedate=p.effective AND p.coid =?; SELECT t.*, c.* FROM `timecards`.`tcardwk` t JOIN `timecards`.`cureffective` c ON c.emailid = t.emailid WHERE t.status='approved' AND t.coid= ? ORDER BY t.wprt, t.emailid;",[coid,coid,coid] , function(error, results) {
              cons.log(query.sql)
              cons.log(error)
              var arrres = results.slice(-1)[0]
              res.jsonp({ persons: arrres, binfo: req.userTok })
          })

      }
  })

  router.get('/taxes/:year', addAppId, bearerTokenCoid, function(req, res) {
    if (!req.userTok.auth) {
      var mess = { message: 'in get /payroll/taxes/:year (not authorized)-' + req.userTok.message }
      cons.log(mess)
      res.jsonp(mess)
    } else {
      const coid = req.userTok.coid
      const year = req.params.year
      var query = conn.query("SELECT account, YEAR(`date`) as year, QUARTER(`date`) as qtr, MONTH(`date`) as mo, SUM(debit) as debit, SUM(credit) as credit FROM gl WHERE coid = ? AND YEAR(`date`) = ? AND ( account='a6041-fedTaxable' || account='a2050-fedWh' || account='a2060-stWh' || account='a6051-stateTaxable' || account='a2010-SS' || account='a2020-medi' || account='a6061-FICAtaxable' || account='a6070-addFICA' || account='a2030-meda' ) GROUP BY YEAR(`date`), QUARTER(`date`), MONTH(`date`), coid, account; SELECT COUNT(DISTINCT(someid)) as numempl, YEAR(`date`) as year, QUARTER(`date`) as qtr FROM gl WHERE someid NOT LIKE 'paid%' AND coid = ? AND YEAR(`date`) = ? GROUP BY YEAR(`date`), QUARTER(`date`); SELECT account, YEAR(`date`) as year, QUARTER(`date`) as qtr, SUM(debit) as debit, SUM(credit) as credit FROM gl WHERE coid = ? AND YEAR(`date`) = ?  AND ( account='a6041-fedTaxable' || account='a2050-fedWh' || account='a2060-stWh' || account='a6051-stateTaxable' || account='a2010-SS' || account='a2020-medi' || account='a6061-FICAtaxable' || account='a6070-addFICA' || account='a2030-meda' ) GROUP BY YEAR(`date`), QUARTER(`date`),coid, account; SELECT YEAR(`date`) as year, QUARTER(`date`) as qtr, MONTH(`date`) as mo, MONTHNAME(`date`) as month, SUM(debit) as paid, SUM(credit) as accrued FROM gl g WHERE coid = ? AND YEAR(`date`)= ? AND ( account='a2010-SS' || account='a2020-medi' || account='a2020-meda' || account='a2050-fedWh') GROUP BY YEAR(`date`), QUARTER(`date`), MONTH(`date`), MONTHNAME(`date`); SELECT YEAR(`date`) as year, QUARTER(`date`) as qtr, SUM(debit) as paid, SUM(credit) as accrued FROM gl g WHERE coid = ? AND YEAR(`date`)= ? AND ( account='a2010-SS' || account='a2020-medi' || account='a2020-meda' || account='a2050-fedWh' ) GROUP BY YEAR(`date`), QUARTER(`date`); SELECT YEAR(`date`) as year, QUARTER(`date`) as qtr, MONTH(`date`) as mo, MONTHNAME(`date`) as month, SUM(debit) as paid, SUM(credit) as accrued FROM gl g WHERE coid = ? AND YEAR(`date`)= ? AND ( account='a2060-stWh' ) GROUP BY YEAR(`date`), QUARTER(`date`), MONTH(`date`), MONTHNAME(`date`); SELECT YEAR(`date`) as year, QUARTER(`date`) as qtr, SUM(debit) as paid, SUM(credit) as accrued FROM gl g WHERE coid = ? AND YEAR(`date`)= ? AND ( account='a2060-stWh' ) GROUP BY YEAR(`date`), QUARTER(`date`)",[coid,year,coid,year,coid,year,coid, year,coid, year,coid,year,coid,year] , function(error, results) {
        cons.log(query.sql)
        cons.log(error)
        res.jsonp({ results: results, binfo: req.userTok })
      })
    }
  })

  router.get('/payments/:year', addAppId, bearerTokenCoid, function(req, res) {
    if (!req.userTok.auth) {
      var mess = { message: 'in get /payroll/payments/:year (not authorized)-' + req.userTok.message }
      cons.log(mess)
      res.jsonp(mess)
    } else {
      const coid = req.userTok.coid
      const year = req.params.year
      var query = conn.query("SELECT wdprt as ref, job as gov, QUARTER(`date`)as qtr, MONTH(`date`)as mo, MONTHNAME(`date`) as month, someid as paydate, credit as paid FROM gl WHERE YEAR(`date`)=? AND coid =? AND account = 'a1010-cash' AND (job='fed' OR job='state') AND cat='WhTaxPayment' AND credit>0 ORDER BY job, `date` ",[year,coid] , function(error, results) {
        cons.log(query.sql)
        cons.log(error)
        res.jsonp({ results: results, binfo: req.userTok })
      })
    }
  })

  router.get('/qtr/state/:year/:qtr', addAppId, bearerTokenCoid, function(req, res) {
    if (!req.userTok.auth) {
      var mess = { message: 'in get /payroll/qtr/state/:year/:qtr (not authorized)-' + req.userTok.message }
      cons.log(mess)
      res.jsonp(mess)
    } else {
      const coid = req.userTok.coid
      const year = req.params.year
      const qtr = req.params.qtr
      const fmo = moment(`${year}-${qtr}`,'YYYY-Q').format('M')*1
      /*
      How many paychecks did each worker get for each month of the quarter
      */
      let qnum = "SELECT DISTINCT(someid) as employee, "
      for (var i = fmo; i<fmo+3; i++){
        const mmm = moment(`${year}-${i}`,'YYYY-M').format('MMM')
        const c = `COUNT(CASE WHEN MONTH(\`date\`)=${i} THEN debit END) as '${mmm}'`
        qnum += c+ ', '
      }
      qnum=  qnum.slice(0,-2)+"FROM gl WHERE coid = ? AND YEAR(`date`) = ? AND QUARTER(`date`)= ? AND account = 'a6050-stateWages' GROUP BY someid; "
      
      /*
      What were wages, taxable wages and witholding for quarter
      */
      const qtot ="SELECT  DISTINCT QUARTER(`date`) as qtr,  \
      SUM(CASE WHEN account='a6050-stateWages' THEN debit END) as 'a6050-stateWages', \
      SUM(CASE WHEN account='a6051-stateTaxable' THEN credit END) as 'a6051-stateTaxable', \
      SUM(CASE WHEN account='a2060-stWh' THEN credit END) as 'a2060-stWh', \
      SUM(CASE WHEN account='a2060-stWh' THEN debit END) as 'a2060-stWh-paid' \
      FROM gl \
      WHERE coid = ? \
      AND YEAR(`date`) = ? \
      AND QUARTER(`date`) =? \
      AND ( \
        account='a6050-stateWages' || \
        account='a6051-stateTaxable' || \
        account='a2060-stWh' \
        )  \
      GROUP BY QUARTER(`date`); " 
      /*
      What were wages, taxable wages and witholding for quarter by person
      */
      let qemp = "SELECT  DISTINCT someid as employee, \
      SUM(CASE WHEN account='a6050-stateWages' THEN debit END) as 'a6050-stateWages', \
      SUM(CASE WHEN account='a6051-stateTaxable' THEN credit END) as 'a6051-stateTaxable', \
      SUM(CASE WHEN account='a2060-stWh' THEN credit END) as 'a2060-stWh' \
      FROM gl \
      WHERE coid = ? \
      AND YEAR(`date`) = ? \
      AND QUARTER(`date`)= ? \
      AND someid NOT LIKE 'paid%' \
      AND ( \
        account='a6050-stateWages' || \
        account='a6051-stateTaxable' || \
        account='a2060-stWh' \
        ) \
      GROUP BY someid; " 
      /*
      List state witholding payments for quarter
      */
      let qpmt = "SELECT MONTH(`date`) as `month`, \
      someid as date_paid, \
      debit as amount \
      FROM gl \
      WHERE account='a2060-stWh' \
      AND coid=? \
      AND YEAR(`date`)=? \
      AND QUARTER(`date`)= ? \
      AND debit>0 \
      ORDER BY MONTH(`date`); "
      /*
      What state payments and acruals for witholding for year
      */
      let yrpayaccr = "SELECT QUARTER(`date`) as qtr, \
      MONTHNAME(`date`) as month, \
      SUM(debit) as paid, SUM(credit) as accrued \
      FROM gl \
      WHERE account='a2060-stWh' \
      AND coid= ? \
      AND YEAR(`date`)= ? \
      GROUP BY QUARTER(`date`), MONTHNAME(`date`)"
      
      var anum = [coid, year, qtr]
      const ayrpayaccr=[coid, year]
      const allres = {}
      const qn = conn.query(qnum, anum, (err,rnum)=>{
        allres.qnumemp=rnum
        console.log('qn.sql: ', qn.sql)
        const qt = conn.query(qtot, anum, (err,rtot)=>{
          allres.qtot=rtot
          console.log('qt.sql: ', qt.sql)
          const qe = conn.query(qemp, anum, (err,remp)=>{
            allres.qemp=remp
            console.log('qe.sql: ', qe.sql)
            const qp = conn.query(qpmt, anum, (err,rpmt)=>{
              allres.qpmt=rpmt
              console.log('qp.sql: ', qp.sql) 
              const qy = conn.query(yrpayaccr, ayrpayaccr, (err,ryrp)=>{
                allres.yrpayaccr=ryrp
                console.log('qy.sql: ', qy.sql)
                console.log('allres: ', allres) 
                res.jsonp({st:allres}) 
              }) 
            })  
          })      
        })
      })
    }
  })

  router.get('/w2/:year', addAppId, bearerTokenCoid, function(req, res) {
    if (!req.userTok.auth) {
      var mess = { message: 'in get /payroll/w2/:year/:qtr (not authorized)-' + req.userTok.message }
      cons.log(mess)
      res.jsonp(mess)
    } else {
      const coid = req.userTok.coid
      const year = req.params.year
      getw2data(year, coid, (results)=>{
        // console.log('results: ', results)
        res.jsonp({results:results})
      })
    }
  })

  router.get('/efw2/:year', addAppId, bearerTokenCoid, function(req, res) {
    if (!req.userTok.auth) {
      var mess = { message: 'in get /payroll/efw2/:year/:qtr (not authorized)-' + req.userTok.message }
      cons.log(mess)
      res.jsonp(mess)
    } else {
      const coid = req.userTok.coid
      const year = req.params.year
      getw2data(year, coid, (results)=>{
        const {fed} = buildEfiles(year,results)
        console.log('fed: ', fed)
        const fname = `${coid}${year}efw2`
        var fzip = new JSZip();
        fzip.file(`${fname}.txt`, fed)
        fzip.generateNodeStream({type:'nodebuffer',streamFiles:true})
          .pipe(fs.createWriteStream(`${fname}.zip`))
          .on('finish', function () {
              // JSZip generates a readable stream with a "end" event,
              // but is piped here in a writable stream which emits a "finish" event.
              console.log(`${fname}.zip is written`);
              res.download(`./${fname}.zip`)
            });
      })
    }
  })

  router.get('/efw2ma/:year', addAppId, bearerTokenCoid, function(req, res) {
    if (!req.userTok.auth) {
      var mess = { message: 'in get /payroll/efw2/:year/:qtr (not authorized)-' + req.userTok.message }
      cons.log(mess)
      res.jsonp(mess)
    } else {
      const coid = req.userTok.coid
      const year = req.params.year
      getw2data(year, coid, (results)=>{
        const {ma} = buildEfiles(year,results)
        console.log('ma: ', ma)
        const fname = `${coid}${year}efw2MA`
        var fzip = new JSZip();
        fzip.file(`${fname}.txt`, ma)
        fzip.generateNodeStream({type:'nodebuffer',streamFiles:true})
          .pipe(fs.createWriteStream(`${fname}.zip`))
          .on('finish', function () {
              // JSZip generates a readable stream with a "end" event,
              // but is piped here in a writable stream which emits a "finish" event.
              console.log(`${fname}.zip is written`);
              res.download(`./${fname}.zip`)
            });
      })
    }
  })

  router.get('/jobcosts/:year', addAppId, bearerTokenCoid, function(req, res) {
    if (!req.userTok.auth) {
      var mess = { message: 'in get /payroll/jobcosts/:year (not authorized)-' + req.userTok.message }
      cons.log(mess)
      res.jsonp(mess)
    } else {
      const coid = req.userTok.coid
      const year = req.params.year
      var query = conn.query("SELECT job, SUM(somenum) as hrs, SUM(debit) as cost, ROUND(SUM(debit)/SUM(somenum),2) as hrcost FROM gl WHERE account = 'a5010-COGS' AND YEAR(`date`)= ? AND coid =? GROUP BY job ORDER BY job; \
      \
      SELECT job, cat, SUM(somenum) as hrs, SUM(debit) as cost, ROUND(SUM(debit)/SUM(somenum),2) as hrcost FROM gl WHERE account = 'a5010-COGS' AND YEAR(`date`)= ? AND coid =? GROUP BY job,cat ORDER BY job,cat; \
      \
      SELECT job, cat, someid, SUM(somenum) as hrs, SUM(debit) as cost, ROUND(SUM(debit)/SUM(somenum),2) as hrcost FROM gl WHERE account = 'a5010-COGS' AND YEAR(`date`)= ? AND coid =? GROUP BY job,cat, someid ORDER BY job,cat,someid;\
      \
      SELECT job, cat, someid as employee, somenum as hrs , wdprt  FROM gl WHERE account = 'a5010-COGS' AND YEAR(`date`)= ? AND coid =? ORDER BY job,cat,wdprt,someid; ",[year,coid,year,coid,year,coid, year,coid] , function(error, results) {
        cons.log(query.sql)
        cons.log(error)
        res.jsonp({ results: results, binfo: req.userTok })
      })
    }
  })
  // router.get('/tcard/:wprt/:emailid', bearerTokenCoid, function(req, res) {
  //     if (!req.userTok.auth) {
  //         var mess = { message: 'in get /payroll/tcard (not authorized)-' + req.userTok.message }
  //         cons.log(mess)
  //         res.jsonp(mess)
  //     } else {
  //         cons.log('req.params: ', req.params)
  //         const wprt = req.params.wprt
  //         const wk = wprt.slice(-2)*1
  //         cons.log('wk: ', wk)
  //         const emailid =req.params.emailid
  //         const wdprt = `${wprt}%`
  //         var query0 = conn.query('SELECT `wprt`, `emailid`, `status`, `hrs` FROM tcardwk WHERE emailid = ? AND coid = ? AND wprt =?', [emailid, req.userTok.coid, wprt], function(error0, wstat) {
  //             cons.log(query0.sql)
  //             cons.log(error0)
  //             cons.log(wstat)
  //             cons.log(wdprt)
  //             var query = conn.query('SELECT `wdprt`, `inout`, `hrs` FROM tcardpu WHERE emailid = ? AND coid = ? AND wdprt LIKE(?)', [emailid, req.userTok.coid, wdprt], function(error1, punch) {
  //                 cons.log(query.sql)
  //                 cons.log(error1)
  //                 var query2 = conn.query('SELECT `wdprt`, `job`, `cat`, `hrs` FROM tcardjc WHERE emailid = ? AND coid = ? AND wdprt LIKE(?)', [emailid, req.userTok.coid, wdprt], function(error2, jcost) {
  //                     cons.log(query2.sql)
  //                     cons.log(error2)
  //                     cons.log(jcost)
  //                     cons.log(punch)
  //                     var q = conn.query('SELECT `job`, `category` FROM jobcatact WHERE week=? AND coid=? ORDER BY idx, category', [wk, req.userTok.coid], function(error3, jobs) {
  //                         cons.log(q.sql)
  //                         cons.log(jobs)
  //                         cons.log(error3)
  //                         const wkarr = combinePuJc(punch, jcost, wk, emailid)
  //                         res.jsonp({ wk: wk, wkarr: wkarr, jobs: jobs, wstat: wstat[0] })
  //                     })
  //                 })
  //             })
  //         })
  //     }
  // });
  return router;
}

// function addDays (x){
//   return x*(24*60*60*1000)
// }
function buildEfiles(year, results){
  const cr ='\n'
  // console.log('results: ', results)
  const co = results[0][0]
  const empinfo = results[1]
  const empdata = results[2]
  const emptot = results[3][0]
  // console.log('co: ', co)
  const bid = `RA121440295WG4N37LN${''.padEnd(4+5)}0${''.padEnd(6)}98`
  const bidma = `RA017701519WG4N37LN${''.padEnd(4+5)}0${''.padEnd(6)}98`
  const coname = co.name.padEnd(57).toUpperCase()
  const loc = ''.padEnd(22)
  const costr = co.street.padEnd(22).toUpperCase()
  const cocity = co.city.padEnd(22).toUpperCase()
  const cost = co.st.toUpperCase()
  const zip = co.zip.replace(/[^0-9]/g,'').padEnd(9)
  const fore = ''.padEnd(5+23+15+2)
  const forre = ''.padEnd(4+23+15+2)
  const erro = `${'TIMOTHY MCKENNA'.padEnd(57+22)}${costr}${cocity}${cost}${zip}${fore}`
  const subma = `${'NOAH D MCKENNA'.padEnd(57+22)}${costr}${cocity}${cost}${zip}${fore}`
  const contact = `${'TIMOTHY MCKENNA'.padEnd(27)}${'8574982574'.padEnd(15+5+3)}${'mckenna.tim@gmail.com'.padEnd(40+3+10+1)}L${''.padEnd(12)}`
  const contactrama = `${'NOAH D MCKENNA'.padEnd(27)}${'8574982732'.padEnd(15+5+3)}${'noahmckenna@gmail.com'.padEnd(40+3+10+1)}L${''.padEnd(12)}`
  const contactre = `${'TIMOTHY MCKENNA'.padEnd(27)}${'8574982574'.padEnd(15+5+10)}${'mckenna.tim@gmail.com'.padEnd(40)}`
  const contactrema = `${'NOAH D MCKENNA'.padEnd(27)}${'8574982732'.padEnd(15+5+10)}${'noahmckenna@gmail.com'.padEnd(40)}`
  // console.log('contact: ', contact, contact.length)
  // console.log('fore.length: ', fore.length)
  // console.log('zip: ', zip, zip.length)
  // console.log('coname: ', coname, coname.length)
  let ra =`${bid}${coname}${loc}${costr}${cocity}${cost}${zip}${fore}${erro}${contact}`
  let rama =`${bidma}${coname}${loc}${costr}${cocity}${cost}${zip}${fore}${subma}${contactrama}`
  let re =`RE${year} ${co.fedein.padEnd(9)}${''.padEnd(9)}0${''.padEnd(4+9)}${coname}${loc}${costr}${cocity}${cost}${zip}N${forre}F 0${contactre}${''.padEnd(194)}`
  console.log('co.stein: ', co.stein)
  let rema =`RE${year} ${co.stein.padEnd(9)}${''.padEnd(9)}0${''.padEnd(4+9)}${coname}${loc}${costr}${cocity}${cost}${zip}N${forre}F 0${contactrema}${''.padEnd(194)}`
  // console.log('ra: ', ra, ra.length)
  // console.log('re: ', re, re.length)
  // console.log('empdata[0]: ', empdata[0]['a2050-fedWh']==null ? 0 : empdata[0]['a2050-fedWh'] )
  // console.log('notNull: ', notNull(empdata[0]['a2050-fedWh']))
  const rae = `${ra}${cr}${re}${cr}`
  // console.log('rae: ', rae)
  const rwa = empdata.map((d,i)=>{
    console.log('d: ', d)
    const ssn = empinfo[i].ssn.replace(/[^0-9]/g,'').padEnd(9,'0')
    const fm = empinfo[i].firstmid.toUpperCase()
    const first = fm.split(' ')[0].padEnd(15)
    const mid = (fm.split(' ')[1]==undefined ? '' : fm.split(' ')[1].replace('.','')).padEnd(15)
    const last = empinfo[i].lastname.padEnd(20).toUpperCase()
    const sufloc = ''.padEnd(4+22)
    const street = empinfo[i].street.padEnd(22).toUpperCase()
    const city = empinfo[i].city.padEnd(22).toUpperCase()
    const st = empinfo[i].st.toUpperCase()
    const zip = empinfo[i].zip.replace(/[^0-9]/g,'').padEnd(9)
    const fore = ''.padEnd(5+23+15+2)
    const wages = Math.round(d['a6041-fedTaxable']*100).toString().padStart(11,'0')
    const fedwh = Math.round(notNull(d['a2050-fedWh'])*100).toString().padStart(11,'0')
    console.log('fedwh: ', fedwh)
    const sswages = Math.round(d['a6061-FICAtaxable']*100).toString().padStart(11,'0')
    const sstax = Math.round(d['a6036-SS']*100).toString().padStart(11,'0')
    console.log('sstax: ', sstax)
    const mediwage= sswages
    const meditax = Math.round(d['a6037-medi']*100).toString().padStart(11,'0')
    console.log('meditax: ', meditax)
    const othe = `${''.padStart(11*21, '0')} 0 00${''.padEnd(23)}`
    const rw = `RW${ssn}${first}${mid}${last}${sufloc}${street}${city}${st}${zip}${fore}${wages}${fedwh}${sswages}${sstax}${mediwage}${meditax}${othe}`
    // console.log('rw: ')
    // console.log(rw, rw.length)
    // console.log('empinfo[i]: ', empinfo[i])
    // console.log('d: ', d)
    return rw
  })

  const rstae = `${rama}${cr}${rema}${cr}`
  const rsta = empdata.map((d,i)=>{
    const ssn = empinfo[i].ssn.replace(/[^0-9]/g,'').padEnd(9,'0')
    const fm = empinfo[i].firstmid.toUpperCase()
    const first = fm.split(' ')[0].padEnd(15)
    const mid = (fm.split(' ')[1]==undefined ? '' : fm.split(' ')[1].replace('.','')).padEnd(15)
    const last = empinfo[i].lastname.padEnd(20).toUpperCase()
    const sufloc = ''.padEnd(4+22)
    const street = empinfo[i].street.padEnd(22).toUpperCase()
    const city = empinfo[i].city.padEnd(22).toUpperCase()
    const st = empinfo[i].st.toUpperCase()
    const zip = empinfo[i].zip.replace(/[^0-9]/g,'').padEnd(9)
    const fore = ''.padEnd(5+23+15+2+2)
    const rp0 = `${'0'.padStart(6+11+11+2+8+8,'0')}${''.padEnd(5+20+6)}${'0'.padStart(2,'0')}`
    const stwages = Math.round(d['a6050-stateWages']*100).toString().padStart(11,'0')
    const stwh = Math.round(notNull(d['a2060-stWh'])*100).toString().padStart(11,'0')
    const othe = `${'0'.padStart(10+1+11+11+7+75+75+25, '0')}`
    const rs = `RS25${''.padEnd(5)}${ssn}${first}${mid}${last}${sufloc}${street}${city}${st}${zip}${fore}${rp0}${stwages}${stwh}${othe}`
    // console.log('rs: ', rs, rs.length)
    // console.log('d: ', d)
    return rs
  })
  let raew = rwa.reduce((acc,r)=>{
    const rcr = `${r}${cr}`
    return acc+rcr
  },rae)

  let rstaew = rsta.reduce((acc,r)=>{
    const rcr = `${r}${cr}`
    return acc+rcr
  },rstae)
  // console.log('rama, rama.lenght: ', rama, rama.length)
  // console.log('rema, rema.lenght: ', rema, rema.length)
  const numrec = empdata.length.toString().padStart(7,'0')
  const wages = Math.round(emptot['a6041-fedTaxable']*100).toString().padStart(15,'0')
  const fedwh = Math.round(notNull(emptot['a2050-fedWh'])*100).toString().padStart(15,'0')
  const sswages = Math.round(emptot['a6061-FICAtaxable']*100).toString().padStart(15,'0')
  const sstax = Math.round(emptot['a6036-SS']*100).toString().padStart(15,'0')
  const stwage = Math.round(emptot['a6050-stateWages']*100).toString().padStart(15,'0')
  const stwh = Math.round(emptot['a2060-stWh']*100).toString().padStart(15,'0')
  const mediwage= sswages
  const meditax = Math.round(emptot['a6037-medi']*100).toString().padStart(15,'0') 
  const othe = `${''.padStart(15*21, '0')}${''.padEnd(98)}`
  const rt =`RT${numrec}${wages}${fedwh}${sswages}${sstax}${mediwage}${meditax}${othe}`
  const rtma =`RT${numrec}${wages}${fedwh}${stwage}${stwh}${mediwage}${meditax}${othe}`
  // console.log('rtma, rtma.length: ', rtma, rtma.length)
  const rf = `RF${''.padEnd(5)}${numrec.padStart(9,'0')}${''.padEnd(496)}`
  raew = `${raew}${rt}${cr}${rf}`
  rstaew = `${rstaew}${rtma}`  
  console.log('rstaew: ', rstaew)
  return({fed:raew, ma:rstaew})
}

function getw2data(year, coid, cb){
  console.log('coid: ', coid)
  conn.query("SELECT  * FROM co WHERE coid = ?;\
    SELECT emailid,firstmid,lastname,street,city,st,zip,ssn FROM cureffective \
    WHERE emailid IN \
    (SELECT  DISTINCT someid as employee\
    FROM gl\
    WHERE coid = ?\
    AND YEAR(`date`) = ?\
    AND someid NOT LIKE 'paid%')\
    AND coid = ?\
    ORDER BY emailid;\
    SELECT  DISTINCT someid as employee, \
    SUM(CASE WHEN account='a6041-fedTaxable' THEN credit END) as 'a6041-fedTaxable',\
    SUM(CASE WHEN account='a2050-fedWh' THEN credit END) as 'a2050-fedWh',\
    SUM(CASE WHEN account='a6061-FICAtaxable' THEN credit END) as 'a6061-FICAtaxable',\
    SUM(CASE WHEN account='a6036-SS' THEN credit END) as 'a6036-SS',\
    SUM(CASE WHEN account='a6037-medi' THEN credit END) as 'a6037-medi',\
    SUM(CASE WHEN account='a6050-stateWages' THEN debit END) as 'a6050-stateWages',\
    SUM(CASE WHEN account='a6051-stateTaxable' THEN credit END) as 'a6051-stateTaxable',\
    SUM(CASE WHEN account='a2060-stWh' THEN credit END) as 'a2060-stWh'\
    FROM gl\
    WHERE coid = 'RRCLLC'\
    AND YEAR(`date`) = ?\
    AND someid NOT LIKE 'paid%'\
    AND (\
      account='a6041-fedTaxable'||\
      account='a2050-fedWh'||\
      account='a6061-FICAtaxable'||\
      account='a6036-SS'||\
      account='a6037-medi'||\
      account='a6050-stateWages' ||\
      account='a6051-stateTaxable' ||\
      account='a2060-stWh'\
      ) \
    GROUP BY someid\
    ORDER BY someid;\
    SELECT \
    SUM(CASE WHEN account='a6041-fedTaxable' THEN credit END) as 'a6041-fedTaxable',\
    SUM(CASE WHEN account='a2050-fedWh' THEN credit END) as 'a2050-fedWh',\
    SUM(CASE WHEN account='a6061-FICAtaxable' THEN credit END) as 'a6061-FICAtaxable',\
    SUM(CASE WHEN account='a6036-SS' THEN credit END) as 'a6036-SS',\
    SUM(CASE WHEN account='a6037-medi' THEN credit END) as 'a6037-medi',\
    SUM(CASE WHEN account='a6050-stateWages' THEN debit END) as 'a6050-stateWages',\
    SUM(CASE WHEN account='a6051-stateTaxable' THEN credit END) as 'a6051-stateTaxable',\
    SUM(CASE WHEN account='a2060-stWh' THEN credit END) as 'a2060-stWh'\
    FROM gl\
    WHERE coid = 'RRCLLC'\
    AND YEAR(`date`) = ?\
    AND someid NOT LIKE 'paid%'\
    AND (\
      account='a6041-fedTaxable'||\
      account='a2050-fedWh'||\
      account='a6061-FICAtaxable'||\
      account='a6036-SS'||\
      account='a6037-medi'||\
      account='a6050-stateWages' ||\
      account='a6051-stateTaxable' ||\
      account='a2060-stWh'\
      ); ", [coid, coid, year, coid, year, year], (err,results)=>{
      // console.log('query.sql: ', query.sql)
      // console.log('err: ', err)
      //console.log('results: ', results)
      cb(results)
    })
}

function notNull(x){
  return x==null ? 0 : x
}