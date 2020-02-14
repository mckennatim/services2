var mysql = require('mysql')
var jwt = require('jwt-simple');
var cons = require('tracer').console();
var cfg = require('../../utilities').cfg
var get = require('../../utilities').get
var conn = require('../../db/mysqldb')
