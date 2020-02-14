var http = require('http')
var passport = require('passport');
var env = require('../env.json')
var cfg= env[process.env.NODE_ENV||'development']
require('./modules/mqtt/mqtt2.js')
var app = require('./cors');
var regtokau = require('./modules/regtokau/regtokau')();
var schedrts = require('./modules/schedule/schedrts')();
var mqtt = require('./modules/mqtt/mqttroutes')();
var dedata = require('./modules/dedata')();

app.use('/api/sched', schedrts);
app.use('/api/reg', regtokau);
app.use('/api/mqtt', mqtt);
app.use('/api/dedata', dedata);

app.get('/api', function (req,res){
  res.send("<h4>in demiot /api</h4>")
});

app.set('port', cfg.port.express || 3000);
var server = http.createServer(app);

server.listen(app.get('port'), function(){
  console.log('Express server listening on port ' + server.address().port);
  console.log('MQTT broker operating on port ' + cfg.port.mqtt);
  console.log('WebClient server MQTT through WS on port ' + cfg.port.ws);
});