var conn = require('../../lib/db/mysqldb')
var moment = require('moment');

const coid = 'reroo'
const year = '2018'
const qtr = '3'
const fmo = moment(`${year}-${qtr}`,'YYYY-Q').format('M')*1
/*
How many paychecks did each worker get for each month of the quarter
*/
let qnum = "SELECT DISTINCT(someid) as numempl, "
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
let qpmt = "SELECT `date` as `month`, someid, debit \
FROM gl \
WHERE account='a2060-stWh' \
AND coid=? \
AND YEAR(`date`)=? \
AND QUARTER(`date`)= ? \
AND debit>0; "
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
  allres.qnum=rnum
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
        }) 
      })  
    })      
  })
})
