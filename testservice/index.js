var jdb = require('jsop');

//var test = require('./test')
//var test2 = require('./test2')
// var test3 = require('./test3')
console.log('in index')
var db= jdb('db.json')
db.spaURL = 'duck'
console.log(db.spaURL)
