var http = require('http')
// var express =require('express')
// var jwt = require('jwt-simple');
var app = require('../expres/lib/cors.js')
const signin = require('../expres/lib/modules/signin')();
var env = require('../expres/env.json')
var cfg= env[process.env.NODE_ENV||'development']
console.log('cfg: ', cfg)

app.use('/api/signin', signin);

app.get('/', function(req,res){
  res.send('home ubdee dut')
})
app.get('/dog', function(req,res){
  res.send('Ulusses')
})

app.get('/home', (req,res)=>{
  res.send('home alone')
})

app.get('/t/', function(req,res){
  res.send('t is a letter')
})

app.set('port', 6082);
var server = http.createServer(app);

server.listen(app.get('port'), function(){
  console.log('IOTexpress server listening on port 6082 ')
});