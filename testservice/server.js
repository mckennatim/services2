var express =require('express')
var app = express()
var routes = require('./routes')()
var duts = express()


duts.get('/', function(req,res){
	res.send('home ubdee dut')
})
duts.get('/dog', function(req,res){
	res.send('Ulusses')
})	

app.get('/', function(req,res){
	res.send('home')
})

app.use('/dut', duts)
app.use('/rts', routes)



app.listen(7081, ()=>{
	console.log('running on empty 7081')
})










































































