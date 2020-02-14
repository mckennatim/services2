var superagent = require('superagent')
var expect = require('expect.js')
var should = require('should')
var _ = require('underscore')
var jwt = require('jwt-simple');
var fs = require('fs');
var env = require('../env.json')
var cfg= env[process.env.NODE_ENV||'development']
var secret = cfg.secret
var moment = require('moment');
 
var httpLoc = cfg.url.local +':'+ cfg.port.express + '/api/'
//expires in an hour
var payload = {
  appId: "reroo-jobs",
  email: "noah@sitebuilt.net",
  exp: Math.floor(Date.now() / 1000) + (60 * 60) 
};
var token = jwt.encode(payload, secret);

var payload2 = {
  appId: "reroo-jobs",
  email: "tim@sitebuilt.net",
  exp: Math.floor(Date.now() / 1000) + (60 * 60) 
};
var token2 = jwt.encode(payload2, secret);

var payload3 = {
  appId: "persons",
  email: "mckenna.tim@gmail.com",
  exp: Math.floor(Date.now() / 1000) + (60 * 60) 
};
var token3 = jwt.encode(payload3, secret);
var payload4 = {
  coid:'reroo',
  appId: "persons",
  email: "mckenna.tim@gmail.com",
  exp: Math.floor(Date.now() / 1000) + (60 * 60) 
};
var ctoken = jwt.encode(payload4, secret);

var payload5 = {
  coid: "RRCLLC",
  appId: "pay",
  email: "mckenna.tim@gmail.com",
  exp: Math.floor(Date.now() / 1000) + (60 * 60) 
};
var token5 = jwt.encode(payload5, secret);

var token6 = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJjb2lkIjoiUlJDTExDIiwicm9sZSI6InBhcnRuZXIiLCJhcHBpZCI6InNpZ251cCIsImVtYWlsaWQiOiJtY2tlbm5hLnRpbUBnbWFpbC5jb20iLCJleHAiOjE1ODA5MzQ2NzQwMzV9.wd-8TSQFAZoqZTi4xDb6z4tEm06_Ic1iD5jVKUqbThc"

createBlWk =(wk)=>{
  let blwk=[]
  const wdprt = `${moment().format('YYYY')}-W${wk.toString().padStart(2,"0")}-`
  for (let i=1;i<=7;i++){
    let obj = {wdprt:wdprt+i, hrs:0, inout:[], jcost:[], jchrs:0}
    blwk.push(obj)
  }
  return blwk
}


const padWkData = (wk, wkarr)=>{
  const blwk = createBlWk(wk)
  const paddedwk= blwk.map((d)=>{
    const fwk = wkarr.filter((wd)=>{
      //console.log('JSON.stringify(wd,null,2): ', JSON.stringify(wd,null,2))
      return wd.wdprt==d.wdprt
    })
    if(fwk.length>0){
      const idx = d.didx
      d=fwk[0]
    }
    return d
  })
  //console.log('JSON.stringify(paddedwk,null,2): ', JSON.stringify(paddedwk,null,2))
  return paddedwk
}

const wkendLast = (apwa)=>{
  for(var i = 6; i<=7;i++ ){
    const fi = apwa.findIndex((a)=>a.wdprt.slice(-1)==i)
    const rec= apwa[fi]
    apwa.splice(fi, 1)
    apwa.push(rec)
  }
  const napwa = apwa.map((wa,i)=>{
    wa.idx=i
    return wa
  })
  return napwa
}

const sumThing=(arr, fld)=>{
  const narr=arr.map((a)=>a[fld])
  return narr
}

const processDb4app =(res)=>{
  const wkarr = wkendLast(adjWk4app(cfg.firstday, res.wkarr))
  const hrs= sumThing(res.wkarr, 'hrs')
  const jchrs= sumThing(res.wkarr, 'jchrs')
  return {wkarr, hrs, jchrs, wstat:res.wstat}
}

cfg.firstday=5
const adjWk4app =(firstday, wkarr)=>{
  const appwkarr= wkarr
    .map((d)=>{
      if (firstday!=1 && d.wdprt.slice(-1)>=firstday){
        d.wdprt= moment(d.wdprt).subtract(7, "days").format("YYYY-[W]WW-E")
      }
      return d
    })
    .sort((a,b)=>a.wdprt > b.wdprt)
  return appwkarr
}

const adjDay4db = (firstday, rec)=>{
  let d = {...rec}
  if (firstday!=1 && d.wdprt.slice(-1)>=firstday){
    console.log('it is greater: ')
    d.wdprt= moment(d.wdprt).add(7, "days").format("YYYY-[W]WW-E")
  }
  return d
}

describe('tcard:', function(){
  it('DELETESs days record ', function(done){
    const nd = '2018-W35-5'
    var url = httpLoc + 'tcard/del'
    superagent.delete(url)
      .set('Authorization', 'Bearer ' + token2)
      .send({wdprt:nd})
      .end(function(e, res) {
        console.log(!!e ? e.status: 'no error')
        console.log(res.body)

        expect(true).to.equal(true)
        done()
      }) 
  }) 

  it('GETs tcard data from api/tcard/week/:wk when passed token', function(done) {
    var url = httpLoc + 'tcard/wstat/35'
    superagent
      .get(url)
      .set('Authorization', 'Bearer ' + token2)
      .end(function(e, res) {
        console.log(res.body)
        expect(res.body).to.be.an('object');
        done()
      })
  })
  it('PUTs tcardwk record back in db if not exists', function(done){
    const nd = JSON.parse('{"wprt":"2018-W35", "hrs":25,"status":"submitted"}')
    var url = httpLoc + 'tcard/updstat'
    superagent.put(url)
      .set('Authorization', 'Bearer ' + token2)
      .send({wkstat: nd})
      .end(function(e, res) {
        console.log(!!e ? e.status: 'no error')
        console.log('processed byserver ',res.body)
        console.log('processed by fetches: ')
        expect(true).to.equal(true)
        done()
      }) 
  })
  it('GETs tcard data from api/tcard/week/:wk when passed token', function(done) {
    var url = httpLoc + 'tcard/week/5'
    superagent
      .get(url)
      .set('Authorization', 'Bearer ' + token2)
      .end(function(e, res) {
        console.log('JSON.stringify(res.body, null, 2)', JSON.stringify(res.body, null, 2))
        const parr= processDb4app(res.body)
        console.log('parr: ', JSON.stringify(parr, null, 2))
        expect(res.body).to.be.an('object');
        done()
      })
  }) 

  it('PUTs tcardjc record back in db /tcard/updjc if not exists', function(done){
    const nd = JSON.parse('{"wdprt":"2018-W35-5", "jcost":[{"job":"Eastie Farm","cat":"constr","hrs":2},{"job":"Marketting","cat":"constr","hrs":3},{"job":"HYCC","cat":"constr","hrs":4.5}],"jchrs":9.5}')
    const nad = adjDay4db(cfg.firstday, nd)
    console.log('nad: ', nad)
    var url = httpLoc + 'tcard/updjc'
    superagent.put(url)
      .set('Authorization', 'Bearer ' + token2)
      .send({tday: nad})
      .end(function(e, res) {
        console.log(!!e ? e.status: 'no error')
        console.log(res.body)
        expect(true).to.equal(true)
        done()
      }) 
  }) 
  it('PUTs tcardjc record back in db /tcard/updjc if not exists', function(done){
    const nd = JSON.parse('{"wdprt":"2018-W35-5", "jcost":[]}')
    const nad = adjDay4db(cfg.firstday, nd)
    console.log('nad: ', nad)
    var url = httpLoc + 'tcard/updjc'
    superagent.put(url)
      .set('Authorization', 'Bearer ' + token2)
      .send({tday: nad})
      .end(function(e, res) {
        console.log(!!e ? e.status: 'no error')
        console.log(res.body)
        expect(true).to.equal(true)
        done()
      }) 
  })  
  it('PUTs days record back in db if not exists', function(done){
    const nd = JSON.parse('{"wdprt":"2018-W35-5","hrs":9.5,"inout":["7:30","15:15","15:45","17:00","16:12"],"jcost":[{"job":"Eastie Farm","cat":"constr","hrs":2},{"job":"Marketting","cat":"constr","hrs":3},{"job":"HYCC","cat":"constr","hrs":4.5}],"jchrs":9.5}')
    const nad = adjDay4db(cfg.firstday, nd)
    var url = httpLoc + 'tcard/update'
    superagent.put(url)
      .set('Authorization', 'Bearer ' + token2)
      .send({tday: nad})
      .end(function(e, res) {
        console.log(!!e ? e.status: 'no error')
        console.log(res.body)
        expect(true).to.equal(true)
        done()
      }) 
  })
  it('PUTs days record back in db if not exists', function(done){
    const nd = JSON.parse('{"wdprt":"2018-W35-5","hrs":0,"inout":[],"jcost":[],"jchrs":0}')
    const nad = adjDay4db(cfg.firstday, nd)
    var url = httpLoc + 'tcard/update'
    superagent.put(url)
      .set('Authorization', 'Bearer ' + token2)
      .send({tday: nad})
      .end(function(e, res) {
        console.log(!!e ? e.status: 'no error')
        console.log(res.body)
        expect(true).to.equal(true)
        done()
      }) 
  }) 
})

describe('regtokau:', function() {
  var agent = superagent.agent();
  var name = 'tim7';
  var ucnt = 0;
  var apikey = 'dog';
  var ureg = 'tim2';
  var uav = 'fred';
  var eregtim = 'tim2@sitebuilt.net';
  var enottim = 'mckenna.nottim@gmail.com';
  it('GET / should be running and return: please select...', function(done) {
    superagent.get(httpLoc+'reg')
      .end(function(e, res) {
        console.log(res.body.message)
        expect(e).to.eql(null)
        expect(res.body).to.be.a('object')
        expect(res.body.message).to.eql('in root of registration module')
        done()
      })
  })
  it('POSTs auth from social-auth when passed token', function(done) {
    var url = httpLoc + 'reg/auth'
    superagent
      .post(url)
      .send({token:token3})
      .end(function(e, res) {
        console.log(res.body)
        expect(res.body).to.be.an('object');
        done()
      })
  })
  it('GETs coids from bearerTokenApp token', function(done) {
    var url = httpLoc + 'reg/coids'
    superagent
      .get(url)
      .set('Authorization', 'Bearer ' + token3)
      .end(function(e, res) {
        console.log(res.body)
        expect(res.body).to.be.an('object');
        done()
      })
  })
  it('GETs ctoken as bearerTokenApp tokData +coid', function(done) {
    var url = httpLoc + 'reg/ctoken/'+'reroo'
    superagent
      .get(url)
      .set('Authorization', 'Bearer ' + token3)
      .end(function(e, res) {
        console.log(res.body)
        expect(res.body).to.be.an('object');
        done()
      })
  })
})
describe('jobs:', function(){
  it('GETs jobs from api/jobs/list when passed token', function(done) {
    var url = httpLoc + 'jobs/list/0'
    superagent
      .get(url)
      .set('Authorization', 'Bearer ' + ctoken)
      .end(function(e, res) {
        console.log(res.body)
        expect(res.body).to.be.an('object');
        done()
      })
  })
  it("Puts a revised job record", function(done){
    let jobs = [{
      job: '12parleyvale',
      category: 'utlities',
      active: 0,
      week: 0,
      idx: 5,
      coid: 'reroo' },
    { 
      job: '12parleyvale',
      category: 'stonework',
      active: 0,
      week: 0,
      idx: 5,
      coid: 'reroo' }]
    var url = httpLoc + 'jobs/update'
    superagent.put(url)
      .set('Authorization', 'Bearer ' + token)
      .send({jobs: jobs})
      .end(function(e, res) {
        console.log(!!e ? e.status: 'no error')
        console.log(res.body)
        expect(true).to.equal(true)
        done()
      })      
  })
  it('deletes a job', function(done){
    job ='12parleyvale'
    var url = httpLoc + 'jobs/del'
    superagent.delete(url)
      .set('Authorization', 'Bearer ' + token)
      .send({job: job})
      .end(function(e, res) {
        console.log(!!e ? e.status: 'no error')
        console.log(res.body)
        expect(true).to.equal(true)
        done()
      })  
  })
})
describe('w2', ()=>{
  it('gets W2 file', (done)=>{
    var url = httpLoc + 'payroll/w2/2019'
    superagent
      .get(url)
      .set('Authorization', 'Bearer ' + token6)
      .end(function(e, res) {
        console.log(res.body)
        expect(res.body).to.be.an('object');
        done()
      })
  })
  it('gets EFW2 file', (done)=>{
    var url = httpLoc + 'payroll/efw2/2019'
    superagent
      .get(url)
      .set('Authorization', 'Bearer ' + token6)
      .end(function(e, res) {
        console.log(res.body)
        expect(res.body).to.be.an('object');
        done()
      })
  })
  it('gets EFW2MA file', (done)=>{
    var url = httpLoc + 'payroll/efw2ma/2019'
    superagent
      .get(url)
      .set('Authorization', 'Bearer ' + token6)
      .end(function(e, res) {
        console.log(res.body)
        expect(res.body).to.be.an('object');
        done()
      })
  })
})


