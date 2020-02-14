var mosca = require('mosca')
var cons = require('tracer').console();
var my=require('./mysqldb')
var cfg= my.cfg
console.log(cfg.db)
var sched =require('./sched')
// var Reco = require('./reco').Reco
// var get = require('./utility').get

var mongoose = require('mongoose');
mongoose.connect(cfg.db.url,{ useNewUrlParser: true });

// const cassandra = require('cassandra-driver');
// const cassClient = new cassandra.Client({ contactPoints: ['sitebuilt.net'], keyspace: 'geniot' });

var authenticate = function(client, username, password, callback) {
  console.log(client.id)
  // cons.log(username)
  // cons.log(password)
  client.token=password.toString()
  if(!username || !password){
    callback(null,false)
    // cons.log('!username or !password')
  }else{
    my.dbAuth(client, username,password.toString(), function(authorized){
      // console.log('authorized = ', authorized, ',appid = '+ client.id)
      if (authorized) {
        client.user = username;
      }
      // console.log(client.user)
      callback(null, authorized);
    })
  }
}

var authorizePublish = function(client, atopic, payload, callback) {
  // cons.log('GOT TO authorizePUBLISH')
  //console.log('client.token: ', client.token)
  var dev = atopic.split('/')[0]
  var topic = atopic.split('/')[1]   
  switch(true){
    case client.id==dev || dev=='presence':
      callback(null,true)
      break;
    case topic=='cmd' || topic=='prg':
      my.dbPublish(client.token, function(cb){
        cons.log(`${client.user} can publish ${dev}/cmd||prg?: ${cb}`)
          if(!cb){
            cons.log('no publishing for you, connected: ',cb)
            //callback (new Error('wrong topic'), true)
            callback (null, cb)
          }else{
            cons.log('you can publish: ' ,cb)
            callback(null,cb)
          }
      }) 
      break
    case topic=='set':
      if(client.user==cfg.super){
        cons.log(`${client.user} is super and can publish ${dev}/set`)
        callback(null,true)
      }else{
        my.dbPubSet(client.token, function(cb){
          cons.log(`${client.user} can publish ${dev}/set?: ${cb}`)
          if(!cb){
            callback (null,cb)
          }else{
            callback(null,cb)
          }
        }) 
      }
      break
    default:
      // cons.log(appId, topic, ' is approved')
     callback(null, true)        
  }
}

var authorizeSubscribe = function(client, topic, callback) {
  var dev = topic.split('/')[0]
  var appId = client.id.split('0.')[0]
  // cons.log(client.id, dev, appId, client.user)
  if(client.id==dev){
    callback(null,true)
  }else{
    my.dbSubscr(client.token, function(cb){
      // cons.log(cb)
      callback(null, cb);      
    })
  }
}

var pubsubsettings = {
  //using ascoltatore
  type: 'mongo',        
  url: 'mongodb://127.0.0.1:27017/mqtt',
  pubsubCollection: 'ascoltatori',
  mongo: {}
};

var moscaSettings = {
  port: cfg.port.mqtt,           //mosca (mqtt) port
  backend: pubsubsettings,//pubsubsettings is the object we created above 
  http: {port: cfg.port.ws, bundle: true, static: './'}    
};
// fired when the mqtt server is ready
function setup() {
  moserver.authenticate = authenticate;
  moserver.authorizePublish = authorizePublish;
  moserver.authorizeSubscribe = authorizeSubscribe;
  console.log('Mosca server is up and running')
  console.log('device mqtt running on port '+cfg.port.mqtt)
  console.log('browser mqtt over ws port '+cfg.port.ws)
  var message = {
    topic: '/hello/world',
    payload: 'abcde', // or a Buffer
    qos: 0, // 0, 1, or 2
    retain: false // or true
  };
  moserver.publish(message, function() {
    console.log('done! SUPER SIMPLE');
  });  
}

var moserver = new mosca.Server(moscaSettings);   //here we start mosca
moserver.on('ready', setup);  //on init it fires up setup()
//var moclient= moserver.on('clientConnected', function(client) {
moserver.on('clientConnected', function(client) {
  console.log('client connected', client.id, client.user);
  return client;
});

moserver.published = function(packet, moclient, cb) {
  if (packet.topic.indexOf('echo') === 0) {
    return cb();
  }
  console.log('Pkt:',packet.topic,packet.payload.toString())
  mq.selectAction(packet.topic)
  mq.processIncoming(packet.payload)  
}

var mq = {
  job: '',
  devid: '', 
  selectAction: function(topic){
    var sp = topic.split("/")
    this.devid = sp[0];
    this.job = sp[1];
    //console.log(this.devid, this.job)
    this[this.job]
  },
  publish: function(packet){
    cons.log ('PUBLISHED')
    var newPacket = {
      topic: 'echo/' + packet.topic,
      payload: packet.payload,
      retain: packet.retain || false,
      qos: packet.qos || 0
    };
    moserver.publish(newPacket, function(){
      console.log('Pukt',  packet.topic , newPacket.payload.toString());
    });    
  },
  processIncoming: function(payload){
    switch(true){
      case this.job=="cmd":
        break
      case this.job=="time":
        console.log("time")
        sched.setTimeAndSched(this.devid, moserver, (results)=>{
          console.log(results)
        })
        break
      case this.job=="mytime":
        var spot = payload.toString()
        const timeobj = sched.findNowAtSpot(spot)
        var topi = 'moment/yourtime'
        var oPacket = {
          topic: topi,
          payload: JSON.stringify(timeobj),
          retain: false,
          qos: 0
        };
        moserver.publish(oPacket, function(){
          console.log('just published yourtime')
        });
        break  
      case this.job=="sched":
        break
      case this.job=="user":
        var pl = JSON.parse(payload.toString())
        var top =`${this.devid}/userInf`
        cons.log(pl.user)
        var pla= `{"canPublish":${true}}`
        var oPacket = {
          topic: top,
          payload: pla,
          retain: false,
          qos: 0
        };    
  
        moserver.publish(oPacket, ()=>{
          cons.log('did PUBLISH IT')
        })          
        break  
      case this.job=="srstate":
        var pl = JSON.parse(payload.toString())
        if(pl.new){
          let temp=null
          let setpt=null
          let calling
          if (pl.darr.length==1){
            calling = pl.darr[0]
          }else{
            temp = pl.darr[0]
            calling = pl.darr[1]
            setpt = (pl.darr[3]+pl.darr[3])/2
          }
          const r = {dev:this.devid, sr:pl.id, temp, setpt, calling}
          my.add2bigdata(r)
        }
        break
      case this.job=="dog":
        break
      default:
    }
  }
}