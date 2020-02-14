var app = require('express')()

var cons = require('tracer').console();
var jwt = require('jwt-simple');
var User = require('../app/models').moUser;
var AppInfo  = require('../app/models').moApp;
var mf = require('./funcs')
var env = require('../env.json')
//var cfg= env[process.env.NODE_ENV||'development']
var cfg= mf.cfg
// cons.log(cfg.base)
var fbCallback=cfg.auth.facebookAuth.callbackURL 


//module.exports = function(passport) {
module.exports = function(passport) {
// normal routes ===============================================================
  
  app.get('/', function(req, res) {
    cons.log('in root')
    cons.log(req.query)
    res.render('hello.ejs');
  });

  app.get('/spa/:appid', function(req, res) {
    cons.log(req.params)
    cons.log(req.hostname)
    appInfo ={
      appId: req.params.appid,
      spaURL: req.headers.referer,
      apiURL: req.query.apiURL,
      cbPath: req.query.cbPath
    }
    mf.upsertSPAinfo(appInfo)
    appInfo.base=cfg.base
    cons.log(appInfo)
    //res.setHeader('Set-Cookie','appId=fauth'); 
    res.cookie('appId', req.params.appid, { maxAge: 900000, httpOnly: false});   
    res.render('index.ejs',appInfo);
  });

  // PROFILE SECTION =========================
  app.get('/profile', isLoggedIn, function(req, res) {
    //cons.log(req.cookies.appId)
    //cons.log(req.user)
    //const appId = mf.getCurrApp()
    var appId
    if(req.cookies.appId){
      cons.log('hay cookies')
      appId = req.cookies.appId
    }else{
      cons.log('no hay cookies')
      appId = mf.getCurrApp()
    }
    const email = req.user.userinfo.emailkey
    AppInfo.findOne({appId: appId}, function(err,result){
      cons.log(result)
      var apiURL = result.apiURL+'/reg/auth'
      mf.sendToApi(appId, email, apiURL, function(message){
        var cburl = result.spaURL+result.cbPath
        cons.log(message)
        mf.sendToSpa(cburl, appId, email, message, res)        
        // cons.log(message)
        // if(message.auth){
        //   cons.log("back from sendToApi in signup")
        //   cons.log(result.spaURL)
        //   const payload= {appId: appId, email: email}
        //   const token =jwt.encode(payload, cfg.apisecrets.geniot)
        //   res.redirect(result.spaURL+result.cbPath+'?email='+email+'&token='+token);        
        // }else{
        //   res.render('message.ejs', message);
        // }        
      })
    })  
  });
  // app.get('/back2app/:appId', isLoggedIn, function(req, res) {
  //   //cons.log(req.user)
  //   //const appId = mf.getCurrApp()
  //   const appId = req.params.appId
  //   const email = req.user.userinfo.emailkey
  //   AppInfo.findOne({appId: appId}, function(err,result){
  //     cons.log(result)
  //     var apiURL = result.apiURL+'/api/reg/auth'
  //     mf.sendToApi(appId, email, apiURL, function(){
  //       cons.log("back from sendToApi back2app/:appId")
  //       cons.log(result.spaURL)
  //       const payload= {appId: appId, email: email}
  //       const token =jwt.encode(payload, cfg.apisecrets.geniot)
  //       res.redirect(result.spaURL+result.cbPath+'?email='+email+'&token='+token);        
  //     })
  //   })  
  // });

  // app.get('/back2app', isLoggedIn, function(req, res) {
  //   //cons.log(req.user)
  //   //const appId = mf.getCurrApp()
  //   const appId = req.user.userinfo.appId
  //   const email = req.user.userinfo.emailkey
  //   AppInfo.findOne({appId: appId}, function(err,result){
  //     //cons.log(result)
  //     var apiURL = result.apiURL+'/api/reg/auth'
  //     mf.sendToApi(appId, email, apiURL, function(){
  //       cons.log("back from sendToApi back2app")
  //       cons.log(result.spaURL)
  //       const payload= {appId: appId, email: email}
  //       const token =jwt.encode(payload, cfg.apisecrets.geniot)
  //       res.redirect(result.spaURL+result.cbPath+'?email='+email+'&token='+token);        
  //     })
  //   })  
  // });

  // LOGOUT ==============================
  app.get('/logout', function(req, res) {
    req.logout();
    res.redirect('/');
  });

// =============================================================================
// AUTHENTICATE (FIRST LOGIN) ==================================================
// =============================================================================

  // locally --------------------------------
    // LOGIN ===============================
    // show the login form
    app.get('/login/:apikey/:email/:appId', function(req, res) {
      var ejsparams = { 
        message: req.flash('loginMessage'), 
        apikey: req.params.apikey, 
        email: req.params.email, 
        appId: req.params.appId,
        base: cfg.base 
      }
      res.render('login.ejs', ejsparams);
    });

    // process the login form
    //passport.authenticate('localapikey', {session: false}),
    app.post('/login/:apikey/:email/:appId', function(req, res) {  
      cons.log(req.body)
      cons.log(req.params)
      User.findOne({'local.apikey': req.body.apikey}, function(err, user) {
        cons.log(user)
        if(err){
          res.render('message.ejs', { message: 'error in database'});
        }
        if(!user){
          res.render('message.ejs', { message: 'apikey doesnt match any user'});
        } else if(user.userinfo.emailkey==req.body.email){
          var updUser = user
          updUser.local.auth = true;
          updUser.save(function(err) {
            if(err){
              res.render('message.ejs', { message: 'you are good but for some reason there is an error in database'});
            }else{
              var appId = req.params.appId
              var email = req.params.email
              AppInfo.findOne({appId: appId}, function(err,result){
                cons.log(result)
                var apiURL = result.apiURL+'/reg/auth'
                if(mf.get('result.spaURL', result)){
                  mf.sendToApi(appId, email, apiURL, function(message){
                    var cburl = result.spaURL+result.cbPath
                    cons.log(message)
                    mf.sendToSpa(cburl, appId, email, message, res)
                    // cons.log(message)
                    // if(message.auth){
                    //   cons.log("back from sendToApi in signup")
                    //   cons.log(result.spaURL)
                    //   const payload= {appId: appId, email: email}
                    //   const token =jwt.encode(payload, cfg.apisecrets.geniot)
                    //   res.redirect(result.spaURL+result.cbPath+'?email='+email+'&token='+token);        
                    // }else{
                    //   var qmess =encodeURIComponent(message.message)
                    //   cons.log(qmess)
                    //   res.render('message.ejs', message);
                    // }        
                  })                
                }else{
                  //res.end('signup didnt work')
                  res.render('message.ejs', { message: 'signup didnt work'});
                }
              })              
            }
          })
        } else {
          res.render('message.ejs', { message: 'not the right apikey for this user'});
        }
      });
    })

    // SIGNUP =================================
    app.get('/signup/:appId', function(req, res) {
      mf.setCurrApp(req.params.appId)
      res.render('signup.ejs', { 
        message: req.flash('signupMessage'),
        appId:  req.params.appId,
        base: cfg.base
      });
    });

    // process the signup form
    app.post('/signup', function(req,res){ 
      cons.log(req.body)
      cons.log(req.url)
      cons.log(req.headers.host)
      cons.log(req.hostname)
      cons.log(req.protocol)
      cons.log(req.headers.origin)
      var baseURL = req.protocol+"s://"+req.headers.host+cfg.base
      //var baseURL = req.headers.origin+cfg.base
      cons.log(baseURL)
      mf.processUser(req.body, baseURL, function(err,status){
        cons.log(status)
        cons.log(err)
        if (err){
          cons.log('in procesuser errror')
          res.end ('Some kind of problem')
        }
        if(status.alreadyRegistered){
          cons.log(status.user)
          const appId = req.body.appId
          const email = req.body.email
          AppInfo.findOne({appId: appId}, function(err,result){
            cons.log(result)
            var apiURL = result.apiURL+'/reg/auth'
            if(mf.get('result.spaURL', result)){
              mf.sendToApi(appId, email, apiURL, function(message){
                var cburl = result.spaURL+result.cbPath
                cons.log(message)
                mf.sendToSpa(cburl, appId, email, message, res)                
                // cons.log(message)
                // if(message.auth){
                //   cons.log("back from sendToApi in signup")
                //   cons.log(result.spaURL)
                //   const payload= {appId: appId, email: email}
                //   const token =jwt.encode(payload, cfg.apisecrets.geniot)
                //   res.redirect(result.spaURL+result.cbPath+'?email='+email+'&token='+token);        
                // }else{
                //   res.render('message.ejs', message);
                // }
              })                
            }else{
              //res.end('signup didnt work')
              res.render('message.ejs', { message: 'signup didnt work'});
            }
          })
        } else{
          //res.end('Check your email from this device and click on the liink to complete the registration')
          res.render('message.ejs', { message: 'Check your email from this device and click on the link to complete the registration'});

        }
      })
    });

  // facebook -------------------------------
    // handle the callback after facebook has authenticated the user
    // app.get('/auth/facebook/callback', function(req,res,next){
    //   cons.log('in callback')
    //   passport.authenticate('facebook', {
    //     callbackURL: fbCallback + "?appId=" + req.query.appId,
    //     failureRedirect : cfg.base+'message'
    //   })(req,res,next) }, function(req,res){
    //     cons.log('returned from callback')
    //     cons.log(req.query.appId)
    //     const appId=req.query.appId
    //     res.redirect(cfg.base+'back2app/'+appId)
    //   });

    // // send to facebook to do the authentication
    // app.get('/auth/facebook/:appId', function(req,res,next){
    //   //mf.setCurrApp(req.params.appId)
    //   cons.log(req.params.appId)
    //   //req.appId=req.params.appId
    //   var callbackURL = fbCallback + "?appId=" + req.params.appId;
    //   passport.authenticate(
    //     'facebook', { scope : 'email', appId: req.params.appId, callbackURL: callbackURL }
    //   )(req,res,next);
    // });
    app.get('/auth/facebook/callback',
      passport.authenticate('facebook', {
        successRedirect : cfg.base+'profile',
        failureRedirect : cfg.base+'message'
      }));

    // send to github to do the authentication
    app.get('/auth/facebook/:appId', function(req,res,next){
      //mf.setCurrApp(req.params.appId)
      req.appId = req.params.appId;
      passport.authenticate(
        'facebook', { scope : 'email' }
      )(req,res,next);
    });


  // github -------------------------------

    // handle the callback after github has authenticated the user
    app.get('/auth/github/callback',
      passport.authenticate('github', {
        successRedirect : cfg.base+'profile',
        failureRedirect : cfg.base+'message'
      }));

    // send to github to do the authentication
    app.get('/auth/github/:appId', function(req,res,next){
      mf.setCurrApp(req.params.appId)
      req.appId = req.params.appId;
      passport.authenticate(
        'github', { scope : 'email' }
      )(req,res,next);
    });

  // twitter --------------------------------

    // handle the callback after twitter has authenticated the user
    app.get('/auth/twitter/callback',
      passport.authenticate('twitter', {
        successRedirect : cfg.base+'profile',
        failureRedirect : cfg.base+'message'
      }));
    // send to twitter to do the authentication
    app.get('/auth/twitter/:appId', function(req,res,next){
      mf.setCurrApp(req.params.appId)
      passport.authenticate(
        'twitter', { scope : 'email' }
      )(req,res,next);
    });



  // google ---------------------------------

    // the callback after google has authenticated the user
    app.get('/auth/google/callback',
      passport.authenticate('google', {
        successRedirect : cfg.base+'profile',
        failureRedirect : cfg.base
      }));
    // send to google to do the authentication
    app.get('/auth/google/:appId', function(req,res,next){
      mf.setCurrApp(req.params.appId)
      passport.authenticate(
        'google', { scope : ['profile', 'email'] }
      )(req,res,next);
    });


// =============================================================================
// AUTHORIZE (ALREADY LOGGED IN / CONNECTING OTHER SOCIAL ACCOUNT) =============
// =============================================================================

  // locally --------------------------------
    app.get('/connect/local', function(req, res) {
      res.render('connect-local.ejs', { message: req.flash('loginMessage') });
    });
    app.post('/connect/local', passport.authenticate('local-signup', {
      successRedirect : cfg.base+'profile', // redirect to the secure profile section
      failureRedirect : cfg.base+'connect/local', // redirect back to the signup page if there is an error
      failureFlash : true // allow flash messages
    }));

  // facebook -------------------------------

    // send to facebook to do the authentication
    app.get('/connect/facebook', passport.authorize('facebook', { scope : 'email' }));

    // handle the callback after facebook has authorized the user
    app.get('/connect/facebook/callback',
      passport.authorize('facebook', {
        successRedirect : cfg.base+'profile',
        failureRedirect : cfg.base
      }));

  // github -------------------------------

    // send to github to do the authentication
    app.get('/connect/github', passport.authorize('github', { scope : 'email' }));

    // handle the callback after github has authorized the user
    app.get('/connect/github/callback',
      passport.authorize('github', {
        successRedirect : cfg.base+'profile',
        failureRedirect : cfg.base
      }));

  // twitter --------------------------------

    // send to twitter to do the authentication
    app.get('/connect/twitter', passport.authorize('twitter', { scope : 'email' }));

    // handle the callback after twitter has authorized the user
    app.get('/connect/twitter/callback',
      passport.authorize('twitter', {
        successRedirect : cfg.base+'profile',
        failureRedirect : cfg.base
      }));


  // google ---------------------------------

    // send to google to do the authentication
    app.get('/connect/google', passport.authorize('google', { scope : ['profile', 'email'] }));

    // the callback after google has authorized the user
    app.get('/connect/google/callback',
      passport.authorize('google', {
        successRedirect : cfg.base+'profile',
        failureRedirect : cfg.base
      }));

// =============================================================================
// UNLINK ACCOUNTS =============================================================
// =============================================================================
// used to unlink accounts. for social accounts, just remove the token
// for local account, remove email and password
// user account will stay active in case they want to reconnect in the future

  // local -----------------------------------
  app.get('/unlink/local', isLoggedIn, function(req, res) {
    var user            = req.user;
    user.local.email    = undefined;
    user.local.password = undefined;
    user.save(function(err) {
      res.redirect('/profile');
    });
  });

  // facebook -------------------------------
  app.get('/unlink/facebook', isLoggedIn, function(req, res) {
    var user            = req.user;
    user.facebook.token = undefined;
    user.save(function(err) {
      res.redirect(cfg.base+'profile');
    });
  });

  // github -------------------------------
  app.get('/unlink/github', isLoggedIn, function(req, res) {
    var user            = req.user;
    user.github.token = undefined;
    user.save(function(err) {
      res.redirect(cfg.base+'profile');
    });
  });

  // twitter --------------------------------
  app.get('/unlink/twitter', isLoggedIn, function(req, res) {
    var user           = req.user;
    user.twitter.token = undefined;
    user.save(function(err) {
      res.redirect(cfg.base+'profile');
    });
  });

  // google ---------------------------------
  app.get('/unlink/google', isLoggedIn, function(req, res) {
    var user          = req.user;
    user.google.token = undefined;
    user.save(function(err) {
      res.redirect(cfg.base+'profile');
    });
  });

  ///--------------------------------------------------------
  // privacy policy and terms of service
  app.get('/privacy',function(req, res) {
    res.render('privacy.ejs')
  });    
  app.get('/terms',function(req, res) {
    res.render('terms.ejs')
  });    
  app.get('/message',function(req, res) {
    res.render('message.ejs', {message: mf.getMessage()})
  });    

  app.get('/redirect',function(req, res) {
    console.log('in /redirect')
    res.redirect('https://cascada.sitebuilt.net')
  });    
  return app
};


// route middleware to ensure user is logged in
function isLoggedIn(req, res, next) {
  if (req.isAuthenticated())
    return next();

  res.redirect('/');
}
