var env = require('../../env.json')
var cfg= env[process.env.NODE_ENV||'development']

const get=(path, props)=>{
  return path.split(".")
    .slice(1)
    .reduce((xs,x)=>(xs && xs[x]) ? xs[x] : null , props)
}

module.exports = {
  cfg: cfg,
  get: get
}