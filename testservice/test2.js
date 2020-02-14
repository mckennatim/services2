var db = require('text-db')('db');

var ai = {appId: 'doggy', spaURL: 'http://localhost/spas/dog'}
db.setItem('spaURL', 'http://localhost/spas/cat' )

console.log('in test2')

console.log(db.getItem('spaURL'))
//console.log(ob)