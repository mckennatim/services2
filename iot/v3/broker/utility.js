var env = require('./env.json')
var cfg= env[process.env.NODE_ENV||'development']


const get=(path, props)=>{
  return path.split(".")
  	.slice(1)
  	.reduce((xs,x)=>(xs && xs[x]) ? xs[x] : null , props)
}

var arr=["CYUR", "Paho", "tim"]
var acache={inp:["CYUR", "Paho", "tim"], res:false}
var mcache={inp:["", "", ""], res:false}
console.log(arr.every((v,i)=>v===mcache.inp[i]))
console.log(arr.every((v,i)=>v===acache.inp[i]))

module.exports ={
	get: get,
	cfg: cfg
}