var superagent = require('superagent')
var expect = require('expect.js')

var should = require('should')
var _ = require('underscore')
var jwt = require('jwt-simple');
var fs = require('fs');
var env = require('../env.json')
var cfg= env[process.env.NODE_ENV||'development']
var secret = cfg.jwt.secret
var exp = cfg.jwt.exp

var httpLoc = 'http://localhost:' + cfg.port.express 
describe('superagent:', function() {
	it('GET / should be running', function(done) {
		superagent.get(httpLoc+ '/spa/duck')
			.end(function(e, res) {
				console.log(res.type)
				expect(e).to.eql(null)
				expect(res.type).to.be('text/html')
				done()
			})
	})
	// it('POST / params and body', function(done) {
	// 	superagent
	// 		.post(httpLoc+'/spa/rxasred')
	// 		.send({
	// 				spaURL: 'http://127.0.0.1/sbdev0/xtest/rxasred-navigo-react/dist/#/',
	// 				apiURL: 'http://127.0.0.1:3005/api'
	// 			})
	// 		.end(function(e, res) {
	// 			console.log(res.type)
	// 			console.log(res.body)
	// 			expect(e).to.eql(null)
	// 			expect(res.type).to.be('text/html')
	// 			done()
	// 		})
	// })	
})
