var superagent = require('superagent')
var expect = require('expect.js')
// var mysql = require('mysql')
var jwt = require('jwt-simple');
// var conn = require('../lib/mysqldb')
var cfg = require('../lib/utilities').cfg
console.log(cfg)

var httpLoc = cfg.url.local +':'+ cfg.port.express + '/api/'
console.log('httpLoc: ', httpLoc)
//expires in an hour
var payload = {
  appId: "blank",
  email: "mckenna.tim@gmail.com",
  exp: Math.floor(Date.now() / 1000) + (60 * 60) 
};

var token = jwt.encode(payload, cfg.secret);

describe('device s2g:', function() {
  it('gets devuserapps for device', function(done){
    expect(true).to.equal(true)
    done()
  })
  it('get s2g/lists', function(done){
    const url = `${httpLoc}s2g/lists`
    console.log('url: ', url)
    superagent
    .get(url)
    .set('Authorization', 'Bearer ' + token)
    .end((e,r)=>{
      console.log('e: ', e)
      console.log(r.body)
      expect(true).to.be(true);
      done()
    })
  })  
})


