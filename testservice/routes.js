var routes =require('express')()
// var express =require('express')
// var routes = express()

module.exports = function(){
	routes.get('/', function(req,res){
		res.send('hellt he fuck lo')
	})
	routes.get('/cat', function(req,res){
		res.send('mabibi')
	})
	return routes
}