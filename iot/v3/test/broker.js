var express =require('express')
var jwt = require('jwt-simple');
var app = express()
var my=require('../broker/mysqldb')
var env = require('../expres/env.json')
var cfg= env[process.env.NODE_ENV||'development']
console.log('cfg: ', cfg)

app.get('/', function(req,res){
  res.send('home ubdee dut')
})
app.get('/dog', function(req,res){
  res.send('Ulusses')
})

app.get('/home', (req,res)=>{
  res.send('home alone')
})

app.get('/dbAuth', (req,res)=>{
  const client = ({id:'demo'})
  const username='anybody'
  const password='dog'
  my.dbAuth(client, username,password.toString(), function(authorized){
    const mess= {authorized :authorized,appid:client.id}
    res.send(mess)
  })
})

app.get('/dbAuthDev', (req,res)=>{
  const client = ({id:'CYURD004'})
  const username='tim@sitebuilt.net'
  const password='geniot'
  my.dbAuth(client, username,password.toString(), function(authorized){
    const mess= {authorized :authorized,appid:client.id}
    res.send(mess)
  })
})

app.get('/dbSubscr', (req,res)=>{
  var data = {
    appid: 'hvac', 
    email: 'tim@sitebuilt.net',
    apploc: '12ParleyVale'
  }
  const token = jwt.encode(data, cfg.secret)
  my.dbSubscr(token, (isauth)=>{
    const mess = {appid: data.appid, authorized:isauth}
    res.send(mess)
  })
})

app.get('/dbPublishObs', (req,res)=>{
  var data = {
    appid: 'hvac', 
    email: 'tim@sitebuilt.net',
    apploc: '4505NHaightAve'
  }
  const token = jwt.encode(data, cfg.secret)
  my.dbPublish(token, (canPublish)=>{
    const mess = {appid: data.appid, canPublish:canPublish}
    res.send(mess)
  })
})

app.get('/dbPublishUser', (req,res)=>{
  var data = {
    appid: 'hvac', 
    email: 'tim@sitebuilt.net',
    apploc: '12ParleyVale'
  }
  const token = jwt.encode(data, cfg.secret)
  my.dbPublish(token, (canPublish)=>{
    const mess = {appid: data.appid, canPublish:canPublish}
    res.send(mess)
  })
})

app.get('/dbPubSetTim', (req,res)=>{
  var data = {
    appid: 'hvac', 
    email: 'tim@sitebuilt.net',
    apploc: '12ParleyVale'
  }
  const token = jwt.encode(data, cfg.secret)
  my.dbPubSet(token, (canPublish)=>{
    const mess = {appid: data.appid, canPublish:canPublish}
    res.send(mess)
  })
})

app.get('/dbPubSetH', (req,res)=>{
  var data = {
    appid: 'hvac', 
    email: 'tim@sitebuilt.net',
    apploc: '4505NHaightAve'
  }
  const token = jwt.encode(data, cfg.secret)
  my.dbPubSet(token, (canPublish)=>{
    const mess = {appid: data.appid, canPublish:canPublish}
    res.send(mess)
  })
})

app.get('/dbPubSetC', (req,res)=>{
  var data = {
    appid: 'hvac', 
    email: 'tim@sitebuilt.net',
    apploc: '255ChestnutAve'
  }
  const token = jwt.encode(data, cfg.secret)
  my.dbPubSet(token, (canPublish)=>{
    const mess = {appid: data.appid, canPublish:canPublish}
    res.send(mess)
  })
})


app.listen(7081, ()=>{
  console.log('running on empty 7081')
})

