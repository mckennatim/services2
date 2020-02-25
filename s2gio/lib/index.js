var app = require('./cors');
const server = require('http').Server(app);
const io = require('socket.io')(server);
var env = require('../env.json')
var cfg= env[process.env.NODE_ENV||'development']
var conn = require('../mysqldb')

io.on('connect', (socket) => {
  io.emit('message', 'connected io')


  socket.on('switch2room', (room)=>{
    console.log('switch2room: ', room)
    socket.leaveAll()
    socket.join(room, ()=>{
      console.log('subscribe ', socket.rooms);  
      io.in(room).emit('message', `inside ${room} party people?`)   
    })
  })

  socket.on('message', (message)=>{
    io.in(message.lid).emit('message',message)
    console.log('message: ', message)
    const qry = conn.query('INSERT INTO items SET ? ON DUPLICATE KEY UPDATE ?', [message,message], (error,results)=>{
      console.log('results: ', results)
    })
  })
});

server.listen(cfg.port.socket);
console.log('wss listening on '+cfg.port.socket);


// socket.on('unsubscribe', (room)=>{
//   console.log('leaving room: ', room)
//   socket.emit('message', 'you unsubscribing from ', room)
//   console.log('Object.keys(socket.rooms): ', Object.keys(socket.rooms))
//   socket.leave(room, ()=>{
//     let rooms = Object.keys(socket.rooms);
//     console.log('unsuscribe ',socket.rooms); 
//   })

// socket.on('unsubscribeAll', ()=>{
//   var rooms = io.sockets.adapter.sids[socket.id]; 
//   for(var room in rooms) { socket.leave(room); }
// })  
  
// })
// socket.on('subscribe', (room)=>{
//   console.log('subs room: ', room)
//   socket.join(room, ()=>{
//     console.log('subscribe ', socket.rooms);  
//     io.in(room).emit('message', `inside ${room} party people?`)   
//   })
// })