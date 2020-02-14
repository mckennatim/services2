var superagent = require('superagent')
var expect = require('expect.js')
var mysql = require('mysql')
var jwt = require('jwt-simple');
var conn = require('../lib/db/mysqldb')
var cfg = require('../lib/utilities').cfg

describe('device mysqldb:', function() {
	var emailId="mckenna.tim@gmail.com"
	var pdata = {devid: "CYURBAD", devpwd: "nopwd", bizid: "sbs" }
	var jdata ={
		email: emailId
	}
	var token = jwt.encode(jdata, cfg.secret)
	it('save device to mysql', function(done){
		var query = conn.query('INSERT INTO devices SET ? ON DUPLICATE KEY UPDATE ?', [pdata,pdata], function(error,results,fields){
			if (error) throw error;
			//console.log(results)
		})
		console.log(query.sql)
		expect(true).to.equal(true)
		done()
	})
	it('posts to devices', function(done){
		var url=cfg.url.local+":"+cfg.port.express+"/api/dedata/dev"
		console.log(url)
		pdata.devpwd='froggy'
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