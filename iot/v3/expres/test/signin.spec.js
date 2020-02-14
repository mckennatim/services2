var superagent = require('superagent')
var expect = require('expect.js')
var should = require('should')
var _ = require('underscore')
var jwt = require('jwt-simple');
var fs = require('fs');
var env = require('../env.json')
var cfg= env[process.env.NODE_ENV||'development']
var secret = cfg.secret

const url ='http://localhost:6082/api/signin'

describe('signin', function(){
  it('heelo test', function(done){
    var ans = [{dog:'fred'}]
    expect(typeof(ans[0])).to.equal("object");
    done()			
  })
  it.skip('/', (done)=>{
    superagent
    .get(url)
    .end((e,r)=>{
      console.log('e: ', e)
      console.log(r.body)
      expect(true).to.be(true);
      done()
    })
  })
})