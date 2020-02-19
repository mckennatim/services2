var superagent = require('superagent')
var expect = require('expect.js')
// var should = require('should')
// var _ = require('underscore')
var jwt = require('jwt-simple');
// var fs = require('fs');
// var cons = require('tracer').console();
var env = require('../env.json')
var cfg= env[process.env.NODE_ENV||'development']
var secret = cfg.secret
 
var httpLoc = cfg.url.local +':'+ cfg.port.express + '/api/'
console.log('httpLoc: ', httpLoc)
//expires in an hour
var payload = {
  appId: "blank",
  email: "mckenna.tim@gmail.com",
  exp: Math.floor(Date.now() / 1000) + (60 * 60) 
};

var token = jwt.encode(payload, secret);

describe('regtokau:', function() {
  it('GET / should be running and return: please select...', function(done) {
    superagent.get(httpLoc+'reg')
      .end(function(e, res) {
        console.log(res.body.message)
        expect(e).to.eql(null)
        expect(res.body).to.be.a('object')
        expect(res.body.message).to.eql('in root of s2g registration module')
        done()
      })
  })
  it('posts aaa to api/reg/auth', function(done){
    var url = httpLoc + 'reg/auth'
    console.log(url)
    superagent
      .post(url)
      .send({token: token})
      .end(function(e, res) {
        console.log('res.body: ', res.body)
        console.log(res.status);
        expect(res.status).to.be(200);
        done();
      })
  })
  it('GETs succeeds w userinfo from api/dedata/appsa when passed token', function(done) {
    var url = httpLoc + 'dedata/apps'
    superagent
      .get(url)
      .set('Authorization', 'Bearer ' + token)
      .end(function() {
        //console.log(res.body)
        expect(true).to.be(true);
        done()
      })
  })
})