var env = require('../../env.json')
var cfg= env[process.env.NODE_ENV||'development']

module.exports = {
	cfg: cfg
}