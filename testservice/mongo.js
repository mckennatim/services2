var moclient = require('mongodb').MongoClient
var mo
moclient.connect("mongodb://localhost/demiot", function(err, db) {
  console.log("Connected successfully to server");
  mo=db;
});
const doit=()=>{
	console.log('didit')
	var recos = mo.collection('recos');
	recos.find({_id:"CYURD001:0"}).limit(1).toArray(function(err, docs){
		console.log(err)
		console.log(docs)
	})
}
setTimeout(doit,2000)


