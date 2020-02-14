var env = require('../env.json')
console.log(env)
console.log(process.env.NODE_ENV)
var cfg= env[process.env.NODE_ENV||'production']
console.log(cfg.port.express)