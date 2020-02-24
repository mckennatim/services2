// const express = require('express');
// const app = express();
// const server = require('http').Server(app);
// const io = require('socket.io')(server);
// app.use(express.static('public'));

// io.on('connect', (socket) => {
//   console.log('conected: ')
//   socket.on('room', (room)=>{
//     console.log('room: ', room)
//     socket.emit('message', 'you suck')
//   })
//   // add custom event listeners here
// });

// server.listen(3222);
// console.log('wss listening on 3222');

const sayDog = ()=>{
  console.log('hi ulysses')
}

module.exports = sayDog;
