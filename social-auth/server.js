// server.js

// set up ======================================================================
// get all the tools we need
var express  = require('express');
var app      = express();
var mongoose = require('mongoose');
var passport = require('passport');
var flash    = require('connect-flash');

var morgan       = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser   = require('body-parser');
//var session      = require('express-session');//causes memory leaks in production
var session      = require('cookie-session');
var cfg = require('./app/funcs').cfg
//console.log(cfg.base)
//var env = require('./env.json')
//var cfg= env[process.env.NODE_ENV||'development']
var configDB = cfg.db;
var port     = cfg.port.express;


// configuration ===============================================================
mongoose.connect(configDB.url, { useNewUrlParser: true, useUnifiedTopology: true }); // connect to our database

require('./app/passport')(passport); // pass passport for configuration

// set up our express application
app.use(morgan('dev')); // log every request to the console
app.use(cookieParser()); // read cookies (needed for auth)
app.use(bodyParser.json()); // get information from html forms
app.use(bodyParser.urlencoded({ extended: true }));

app.set('view engine', 'ejs'); // set up ejs for templating

// required for passport
app.use(session({
    secret: 'ilovescotchscotchyscotchscotch', // session secret
    resave: true,
    saveUninitialized: true
}));
app.use(passport.initialize());
app.use(passport.session()); // persistent login sessions
app.use(flash()); // use connect-flash for flash messages stored in session
// routes ======================================================================
//require('./app/routes.js')(app, passport); // load our routes and pass in our app and fully configured passport
var routes = require('./app/routes.js')(passport); // load our routes and pass in our app and fully configured passport
var base = cfg.base
console.log(base)

app.use('/', routes)
// launch ======================================================================
app.listen(port);
console.log('The magic happens on port ' + port);
