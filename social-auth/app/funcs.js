var nodemailer = require('nodemailer')
var cons = require('tracer').console();
var fs = require('fs')
var jwt = require('jwt-simple');
var superagent = require('superagent')
var AppInfo = require('../app/models').moApp;
var User = require('../app/models').moUser;
var env = require('../env.json')
var cfg= env[process.env.NODE_ENV||'development']
//cons.log(process.env)
//console.log(cfg)
var referer = 'http://192.168.1.237:7080/spa/tauth_lo?apiURL=http%3A%2F%2F10.0.1.102%3A3332&cbPath=%23registered'
const parseBetween=(str, fromhere, tohere)=>{
  var flen=fromhere.length
  var sstr= str.substring(str.indexOf(fromhere)+flen)
  var middle= sstr.substring(0, sstr.indexOf(tohere))
  return middle
}
//console.log(parseBetween(referer, '/spa/', '?'))


var pmessage='yo what up'

const setMessage = (message)=>{
  pmessage=message;
}

const getMessage =()=>pmessage

const sendToApi=(appId, email, apiURL, callback)=>{
  cons.log(appId)
  cons.log(email)
  var expmin = (get('cfg.apps[appId].expdays',cfg)||0.5)*24 
  var data = {
    appId: appId, 
    email: email,
    exp: Math.floor(Date.now() / 1000) + (expmin * 60) 
  }
  var token = jwt.encode(data, cfg.apisecrets.geniot)
  cons.log(token)
  cons.log(apiURL)
  cons.log("gonna send to /api/reg/auth/")
  superagent
    .post(apiURL)
    .send({token: token})
    .end(function(e, res){
      //cons.log(res.body)
      callback(res.body)
    })
  // setTimeout(callback, 2000)
}

const sendToSpa=(cburl,appId,email,message,res)=>{
  cons.log(message)
  if(message.auth){
    const payload= {appId: appId, email: email}
    const token =jwt.encode(payload, cfg.apisecrets.geniot)
    res.redirect(cburl+'?email='+email+'&token='+token);        
  }else{
    var qmess =encodeURIComponent(message.message)
    cons.log(qmess)
    res.redirect(cburl+'?email='+email+'&message='+qmess); 
  }
}

const getCurrApp=()=>{
	return fs.readFileSync('appid','utf8')
}

const setCurrApp= (ai)=>{
	fs.writeFile('appid', ai, (err)=>{if(err) {cons.log(err);}})
}

const getRedirect = (ai)=>{
	AppInfo.findOne({appId: ai}, function(err,result){
		console.log(result.spaURL)
	})	
}

const theRedirect =(err, result)=>{
	cons.log(result)
}

const get=(path, props)=>{
  return path.split(".")
  	.slice(1)
  	.reduce((xs,x)=>(xs && xs[x]) ? xs[x] : null , props)
}

var createRandomWord = function(length) {
	var consonants = 'bcdfghjklmnpqrstvwxyz',
		vowels = 'aeiou',
		rand = function(limit) {
			return Math.floor(Math.random() * limit);
		},
		i, word = '',
		length = parseInt(length, 10),
		consonants = consonants.split(''),
		vowels = vowels.split('');
	for (i = 0; i < length / 2; i++) {
		var randConsonant = consonants[rand(consonants.length)],
			randVowel = vowels[rand(vowels.length)];
		word += (i === 0) ? randConsonant.toUpperCase() : randConsonant;
		word += i * 2 < length - 1 ? randVowel : '';
	}
	return word;
}

const upsertSPAinfo = (appInfo)=>{
	AppInfo.update({appId: appInfo.appId}, appInfo, {upsert: true}, function(err,result){})
}

var createRandomWord = function(length) {
	var consonants = 'bcdfghjklmnpqrstvwxyz',
		vowels = 'aeiou',
		rand = function(limit) {
			return Math.floor(Math.random() * limit);
		},
		i, word = '',
		length = parseInt(length, 10),
		consonants = consonants.split(''),
		vowels = vowels.split('');
	for (i = 0; i < length / 2; i++) {
		var randConsonant = consonants[rand(consonants.length)],
			randVowel = vowels[rand(vowels.length)];
		word += (i === 0) ? randConsonant.toUpperCase() : randConsonant;
		word += i * 2 < length - 1 ? randVowel : '';
	}
	return word;
}

const createApikey=()=>{
	return createRandomWord(24)
}

const emailApikey = (apikey, email, appId, baseURL, callback) =>{
  cons.log(baseURL)
	let smtpTransport = nodemailer.createTransport({
		service: 'gmail',
    auth: cfg.gmail.auth
  });
  const loginURL=baseURL+'login'
  var mailOptions = {
      from: "SocialAuth <mckenna.tim@gmail.com>", // sender address
      to: email, // list of receivers
      subject: "apikey", // Subject line
      text: "Your apikey for " +appId + " is: " +apikey + "Return to souath "+loginURL+"/"+apikey+"/"+email+"/"+appId+" and enter your apikey to complete registration for your device", // plaintext body
      html: "<b>Your apikey for " +appId + " is: " +apikey + "</b><p>Return to soauth "+loginURL+"/"+apikey+"/"+email+"/"+appId+" and enter your apikey to complete registration for your device </b></p>" // html body
  }
  var ret=""
  smtpTransport.sendMail(mailOptions, function(error, response){
      if(error){
        console.log(error);
        ret = error;
      }else{
        console.log("Message sent: " + response.message);
        ret = {message: 'check your email and come back'} 
      }
      smtpTransport.close(); // shut down the connection pool, no more messages
      console.log(ret)
      callback(ret);
  });
}

const processUser = (reqbody, baseURL, done)=>{
  cons.log(baseURL)
  try{
    var email = reqbody.email.toLowerCase();
    var appId = reqbody.appId;
  }catch(err){
    cons.log(err)
    req.flash({message: 'bad param'});
    done(err);
    return
  }
  User.findOne({'userinfo.emailkey': email}, function(err, user) {
    var apikey
    if(!user){
      //create user, create apikey and send it
      apikey = createApikey()
      cons.log(baseURL)

      emailApikey(apikey, email, appId, baseURL, function(ret){
        cons.log(ret)
        req.flash({message: ret});
      })          
      var newUser = new User();
      newUser.local.apikey = apikey;
      newUser.local.auth = false;
      newUser.userinfo.emailkey = email;
      newUser.save(function(err) {
        if (err) done(err);
        done(null, {apikey: apikey, alreadyRegistered: false});
        return
      });          
    }
    if(user){
      if(!get('user.local.apikey',user) || user.local.apikey.length <10){
        cons.log('apikey not good')
        apikey = createApikey()
        emailApikey(apikey, email, appId, baseURL, function(ret){
          cons.log(ret)
          //req.flash({message: ret});
        })
        var updUser = user
        updUser.local.apikey = apikey;
        updUser.local.auth = false;
        updUser.save(function(err) {
          if (err) done(err);
          done(null, {apikey: apikey, alreadyRegistered: false});
          return
        });            
      } else if(true || !user.local.auth){//HACK TO FORCE NEW APIKEY
        cons.log('IN NOT user.local.auth')
        apikey = user.local.apikey
        emailApikey(apikey, email, appId, baseURL, function(ret){
          cons.log(ret)
          //req.flash({message: ret});
        })
        var updUser = user
        updUser.local.apikey = apikey;
        updUser.local.auth = false;
        updUser.save(function(err) {
          if (err) done(err);
           done(null, {apikey: apikey, alreadyRegistered: false});
          return
        });        
        // done(null, {apikey: apikey, alreadyRegistered: false,  user: updUser});
        // return
      } else {
        apikey = user.local.apikey
        done(null, {apikey: apikey, alreadyRegistered: true,  user: user});
        return
      }
    }
    cons.log(apikey)
    //cons.log(err)
  })	
}

module.exports = {
  sendToApi: sendToApi,
  sendToSpa: sendToSpa,
	upsertSPAinfo: upsertSPAinfo,
	getCurrApp: getCurrApp,
	setCurrApp: setCurrApp,
	get: get,
	createApikey: createApikey,
	processUser: processUser,
  cfg: cfg,
  getMessage: getMessage,
  setMessage: setMessage,
  parseBetween: parseBetween
}
