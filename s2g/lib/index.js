var http = require('http')
    // var passport = require('passport');
var env = require('../env.json')
var cfg = env[process.env.NODE_ENV || 'development']
var app = require('./cors');
var regtokau = require('./modules/regtokau/regtokau')();
var s2g = require('./modules/s2g/s2g')();
var wss = require('./modules/wss/wss')();
// var socketio = require('socket.io')

app.use('/api/reg', regtokau);
app.use('/api/s2g', s2g);
// app.use('/api/wss', wss);

app.get('/api', function(req, res) {
    res.send("<h4>in s2gt server /api</h4>")
});

app.set('port', cfg.port.express || 3011);
var server = http.createServer(app);


server.listen(app.get('port'), function() {
    console.log('s2g server listening on port ' + server.address().port);
})

// // module.exports = io;
// // var io = socketio.listen(server)
// var io = require('socket.io')(server)


// io.on('connection', (socket) => {
//     console.log('connected t0 socketio')
//     socket.on('room', (room)=>{
//         console.log('room', room)
//     })
// });

