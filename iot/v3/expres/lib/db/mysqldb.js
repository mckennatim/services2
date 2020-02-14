var mysql      = require('mysql');
var env = require('../../env.json')
var cfg= env[process.env.NODE_ENV||'development']

module.exports = mysql.createConnection(cfg.mysql);