var superagent = require('superagent')
var expect = require('expect.js')
var mysql = require('mysql')
var jwt = require('jwt-simple');
var conn = require('../lib/db/mysqldb')
var cfg = require('../lib/utilities').cfg
console.log(cfg)

var emailId="mckenna.tim@gmail.com"
var pdata = {devid: "CYURBAD", devpwd: "nopwd", bizid: "sbs" }
var jdata ={
  email: emailId
}
//var token = jwt.encode({ appId: 'hvac', email: 'tim@sitebuilt.net' }, cfg.secret)
var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhcHBJZCI6Imh2YWMiLCJlbWFpbCI6InRpbUBzaXRlYnVpbHQubmV0In0.e8oviN49uxjbc9FgcyPWV-vQYp0YlD183FhqCWzpuT0"
//https://services.sitebuilt.net/soauth/spa/builder?apiURL=https%3A%2F%2Fservices.sitebuilt.net%2Fiotex%2Fapi&cbPath=%23registered
// var buildertoken = jwt.encode({ appId: 'builder', email: 'mckenna.tim@gmail.com' }, cfg.secret)

var buildertoken ="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhcHBJZCI6ImJ1aWxkZXIiLCJlbWFpbCI6Im1ja2VubmEudGltQGdtYWlsLmNvbSJ9.MW30IpRrhG6Uw9kVsML9phZ1I6IDClYnllBp0ExM6YY"
console.log(buildertoken)

describe('device mysqldb:', function() {
  it('gets devuserapps for device', function(done){
    expect(true).to.equal(true)
    done()
  })
  it.skip('save device to mysql', function(done){
    var query = conn.query('INSERT INTO devices SET ? ON DUPLICATE KEY UPDATE ?', [pdata,pdata], function(error,results,fields){
      if (error) throw error;
      //console.log(results)
    })
    console.log(query.sql)
    expect(true).to.equal(true)
    done()
  })
  it.skip('posts to devices', function(done){
    var url=cfg.url.local+":"+cfg.port.express+"/api/dedata/dev"
    console.log(url)
    pdata.devpwd='froggy'
    console.log(pdata)
    superagent.post(url)
      .set('Authorization', 'Bearer ' + token)
      .send(pdata)
      .end(function(e, res) {
        console.log(!!e ? e.status: 'no error')
        //console.log(res.body)
        expect(true).to.equal(true)
        done()
      })
  })
  it.skip('posts to users', function(done){
    var url=cfg.url.local+":"+cfg.port.express+"/api/dedata/users"
    console.log(url)
    pdata.devpwd='froggy'
    superagent.post(url)
      .set('Authorization', 'Bearer ' + token)
      .send(pdata)
      .end(function(e, res) {
        console.log(!!e ? e.status: 'no error')
        //console.log(res.body)
        expect(true).to.equal(true)
        done()
      })
  })
  it.skip('posts to dedata/prg', function(done){
    var url=cfg.url.local+":"+cfg.port.express+"/api/dedata/prg"
    console.log(url)
    var devid = "CYURD001"
    var day = 4
    var senrel= 0
    var pro = "[[12,40,77,73]]"
    var sdata=`{"devid":"${devid}","dow":${day},"senrel":${senrel},"sched":"${pro}"}`
    console.log(sdata)
    var pdata = JSON.parse(sdata)
    //pdata.sched=pro
    console.log(pdata)
    //pdata=`{"device":${devid},"day":${day},"senrel":${senrel},"pro":${pro}`
    superagent.post(url)
      .set('Authorization', 'Bearer ' + token)
      .send(pdata)
      .end(function(e, res) {
        console.log(!!e ? e.status: 'no error')
        console.log(res.body)
        expect(true).to.equal(true)
        done()
      })
  })
  it('posts to dedata/scheds', function(done){
    var url=cfg.url.local+":"+cfg.port.express+"/api/dedata/scheds"
    console.log(url)
    var pdata = [{"devid":"CYURD001","senrel":0,"dow":0,"season":"current","sched":"[[0,0,65,63],[20,12,78,76],[22,50,55,53],[23,50,64,61]]"},{"devid":"CYURD001","senrel":0,"dow":1,"season":"current","sched":"[[0,0,55,53],[19,12,78,76],[20,50,55,53],[22,50,64,61]]"},{"devid":"CYURD001","senrel":0,"dow":3,"season":"current","sched":"[[0,0,55,53],[19,12,78,76],[20,50,55,53],[22,50,64,61]]"},{"devid":"CYURD001","senrel":0,"dow":5,"season":"current","sched":"[[0,0,55,53],[19,12,78,76],[20,50,55,53],[22,50,64,61]]"},{"devid":"CYURD001","senrel":0,"dow":4,"season":"current","sched":"[[0,0,55,53],[17,12,78,76],[20,50,55,53],[22,50,64,61]]"},{"devid":"CYURD001","senrel":0,"dow":8,"season":"current","sched":"[[0,0,52,49]]"}]
    //pdata.sched=pro
    console.log(pdata)
    //pdata=`{"device":${devid},"day":${day},"senrel":${senrel},"pro":${pro}`
    superagent.post(url)
      .set('Authorization', 'Bearer ' + token)
      .send(pdata)
      .end(function(e, res) {
        console.log(!!e ? e.status: 'no error')
        console.log(res.body)
        expect(true).to.equal(true)
        done()
      })
  })
})
describe('device mongo:', function() {
  it.skip('posts to dedat/rec', function(done){
    var url=cfg.url.local+":"+cfg.port.express+"/api/dedata/rec"
    console.log(url)
    var devid = "CYURD006"
    var senrel= 0
    var sdata=devid+':'+senrel
    var odata ={id:sdata}
    superagent.post(url)
      .set('Authorization', 'Bearer ' + token)
      .send(odata)
      .end(function(e, res) {
        console.log(!!e ? e.status: 'no error')
        console.log(res.body)
        expect(true).to.equal(true)
        done()
      })
  })
  it.skip('deletes dedat/rec', function(done){
    var url=cfg.url.local+":"+cfg.port.express+"/api/dedata/rec"
    console.log(url)
    var devid = "CYURD006"
    var senrel= 0
    var sdata=devid+':'+senrel
    var odata ={id:sdata}
    superagent.delete(url)
      .set('Authorization', 'Bearer ' + token)
      .send(odata)
      .end(function(e, res) {
        console.log(!!e ? e.status: 'no error')
        console.log(res.body)
        expect(true).to.equal(true)
        done()
      })
  })
  it.skip('GETs locids ', function(done) {
    var userid='tim@sitebuilt.net'

    var url = cfg.url.local+":"+cfg.port.express + '/api/dedata/loclist'
    console.log(url);
    superagent
      .get(url)
      .set('Authorization', 'Bearer ' + token)
      .end(function(e, res) {
        console.log(res.body)
        expect(true).to.be(true);
        done()
      })
  })
  it('GETs loc/:locid devices', function(done) {
    var locid='12ParleyVale'
    var url = cfg.url.local+":"+cfg.port.express + '/api/dedata/loc/'+locid
    console.log(url);
    superagent
      .get(url)
      .set('Authorization', 'Bearer ' + token)
      .end(function(e, res) {
        console.log(res.body)
        expect(true).to.be(true);
        done()
      })
  })
  it('GETs scheds/:devid/:sr devices', function(done) {
    var devid='CYURD001'
    var sr="0"
    var url = cfg.url.local+":"+cfg.port.express + '/api/dedata/scheds/'+devid+'/'+sr
    console.log(url);
    superagent
      .get(url)
      .set('Authorization', 'Bearer ' + token)
      .end(function(e, res) {
        console.log(res.body)
        expect(true).to.be(true);
        done()
      })			
  })
})
describe('admin:', function(done) {
  it('gets to admin/devlist', function(done){
    var url=cfg.url.local+":"+cfg.port.express+"/api/admin/devlist"
    console.log(url)
    console.log(buildertoken)
    superagent
      .get(url)
      .set('Authorization', 'Bearer ' + buildertoken)
      .end(function(e, res) {
        console.log(res.body)
        expect(true).to.be(true);
        done()
      })
  })
  it('posts a devices', function(done){
    var url=cfg.url.local+":"+cfg.port.express+"/api/admin/b/savedev"
    console.log(url)
    pdata.devpwd='froggy'
    console.log(pdata)
    superagent.post(url)
      .set('Authorization', 'Bearer ' + token)
      .send(pdata)
      .end(function(e, res) {
        console.log(!!e ? e.status: 'no error')
        console.log(res.body)
        expect(true).to.equal(true)
        done()
      })
  })
  it('gets to admin/i/devzones', function(done){
    var url=cfg.url.local+":"+cfg.port.express+"/api/admin/i/devzones"
    console.log(url)
    console.log(buildertoken)
    let mytoken ="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhcHAiOiJodmFjIiwiZW1haWwiOiJ0aW1Ac2l0ZWJ1aWx0Lm5ldCIsImxvYyI6IjEyUGFybGV5VmFsZSIsInJvbGUiOiJhZG1pbiIsImV4cCI6MTU3NDI3MzY5Mjc3MH0.kGXPHBO7SYj2d8MyY5K5Yf6EWxR47q-qurZCCW4PPi8"
    
    // eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhcHAiOiJjYXNjYWRhIiwiZW1haWwiOiJtY2tlbm5hLnRpbUBnbWFpbC5jb20iLCJsb2MiOiIxMC0xMlBhcmxleVZhbGUiLCJyb2xlIjoiYWRtaW4iLCJleHAiOjE1NjMwNjI3OTgyMTV9.x9eTZHEIUBiXYRjvLGFD4TCOet4ZUBHlzUvMEqEg7hk"
    superagent
      .get(url)
      .set('Authorization', 'Bearer ' + mytoken)
      .end(function(e, res) {
        console.log(res.body)
        console.log(res.body.devs)
        expect(true).to.be(true);
        done()
      })
  })	
})
