trouble moving socketio server from localhost to ssl nginx

Some of the stesp I have taken include

* modifying nginx setup

      map $http_upgrade $connection_upgrade {
          default upgrade;
          ''      close;
      }

      server {
        server_name services.parleyvale.com;
      ...
      location /s2gio/ {
        proxy_pass http://127.0.0.1:3222;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_cache_bypass $http_upgrade;
      }...

but network tab gave me 404's so on my client (react) app added

* modifying client

      //var socket = io.connect(cfg.urls.socket)

      var socket = io.connect(cfg.urls.socket,{
        secure: true,
        rejectUnauthorized: false,
        path: '/s2gio/socket.io'
      });

slightly better but the server was not responding so on the server added

* modifying server

      //const io = require('socket.io')(server)

      const io = require('socket.io')(server,
      { 
        secure: true,
        rejectUnauthorized: false, 
        path: '/s2gio/socket.io'
      });

      io.of('/s2gio')

now the messages from client show up on server but they do not 'emit' from the server. 

comparing the ssl nginx debug file

      2020-03-12T19:12:36.309Z socket.io:socket emitting event ["message",{"lid":"Jutebi","product":"Avacado","done":1,"jsod":"","loc":"produce"}]
      2020-03-12T19:12:36.309Z socket.io:socket dispatching an event ["message",{"lid":"Jutebi","product":"Avacado","done":1,"jsod":"","loc":"produce"}]

that's all I get before they both go back to writing 2's and 3's. But localhost does `encodes, encoding, writing and sending`

      2020-03-12T19:12:36.309Z socket.io:socket emitting event ["message",{"lid":"Jutebi","product":"Avacado","done":1,"jsod":"","loc":"produce"}]
      2020-03-12T19:12:36.309Z socket.io:socket dispatching an event ["message",{"lid":"Jutebi","product":"Avacado","done":1,"jsod":"","loc":"produce"}]
      message:  { lid: 'Jutebi',
        product: 'Red potatoes',
        done: 0,
        jsod: '',
        loc: 'dairy' }
        socket.io-parser encoding packet {"type":2,"data":["message",{"lid":"Jutebi","product":"Red potatoes","done":0,"jsod":"","loc":"dairy"}],"nsp":"/"} +16ms
        socket.io-parser encoded {"type":2,"data":["message",{"lid":"Jutebi","product":"Red potatoes","done":0,"jsod":"","loc":"dairy"}],"nsp":"/"} as 2["message",{"lid":"Jutebi","product":"Red potatoes","done":0,"jsod":"","loc":"dairy"}] +0ms
        socket.io:client writing packet ["2[\"message\",{\"lid\":\"Jutebi\",\"product\":\"Red potatoes\",\"done\":0,\"jsod\":\"\",\"loc\":\"dairy\"}]"] +15m
        engine:socket sending packet "message" (2["message",{"lid":"Jutebi","product":"Red potatoes","done":0,"jsod":"","loc":"dairy"}]) +17ms
        engine:ws writing "42["message",{"lid":"Jutebi","product":"Red potatoes","done":0,"jsod":"","loc":"dairy"}]" +19ms
        qry.sql:  INSERT INTO items SET `lid` = 'Jutebi', `product` = 'Red potatoes', `done` = 0, `jsod` = '', `loc` = 'dairy' ON DUPLICATE KEY UPDATE `lid` = 'Jutebi', `product` = 'Red potatoes', `done` = 0, `jsod` = '', `loc` = 'dairy'

the server is pretty simple     

      const io = require('socket.io')(server);

      io.on('connect', (socket) => {
        io.emit('message', 'connected io')


        socket.on('switch2room', (room)=>{
          console.log('swwwwww')
          console.log('switch2room: ', room)
          socket.leaveAll()
          socket.join(room, ()=>{
            console.log('subscribe ', socket.rooms);  
            io.in(room).emit('message', `inside ${room} party people?`)   
          })
        })

        socket.on('message', (message)=>{
          console.log('message: ', message)
          io.in('/s2gio/'+message.lid).emit('message',message)
          if(message.done==-1){
            const qry=conn.query('DELETE FROM items WHERE lid=? AND product=?',[message.lid,message.product],()=>{
              console.log('qry.sql: ', qry.sql)
            })
          }else{
            const qry = conn.query('INSERT INTO items SET ? ON DUPLICATE KEY UPDATE ?', [message,message], (error,results)=>{
              console.log('qry.sql: ', qry.sql)
            })
          }
        })
      });

      server.listen(cfg.port.socket);
      console.log('wss listening on '+cfg.port.socket);

I also tried adding 'namespace' in emit on the server

      io.on('connect', (socket) => {
        io.emit('message', '/s2gio/connected io')
      ...

Any ideas would be greatly appreciated

map $http_upgrade $connection_upgrade {
    default upgrade;
    ''      close;
}