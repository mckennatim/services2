var expect = require('chai').expect
//var schedut = require('../lib/modules/schedule/schedutil')
var prog = require('./prog.json')


describe('datetime dtutils', function(){
	it('flattenProgObj', function(done){
		var ans = [{dog:'fred'}]
		expect(typeof(ans[0])).to.equal("object");
		done()			
	})
})