# iot summary
## version 3 v3
There is no compelling reason the change brokers authenticate or authorize. 
### table analysis
* `devs` has one to one on device to owners and has locid
* `user_app_loc` has all types of users, apps, auth and roles. _A reasonable change to consider is replacing devicid with locid_. What are the implications? 

broker
* broker/authenticate/dbAuth(device) `"SELECT devid, devpwd, owner FROM devs WHERE devid=?"` checks for match to depwd and devid
* broker/authenticate/dbAuth(appid.random) `if(tokdata.appId==clientid && tokdata.email==username)` no db call unless anybody
* broker/authorizeSubsribe/dbSubscr  There are 2 kinds of subscribe, 
   1. devices subscribing to broker/apps `STATE.cpp/labels_t::scribedTo[] ={"devtime", "cmd", "prg", "req", "set", "progs"};` These are handled by `if(client.id==topic.split('/')[0])` since the client.id of a device is its devid else...
   2. apps subscribing to devices. Now theoretically the app is only connected to this device due to some data it has about which devices are associated with this app@loc. So we don't care if deviceid is in the database query. All we need to know is that it is OK for this device to be subscribed to by the app@loc for this user and that its owner says it is OK. appid, locid and emailid can come from the token  If token.appid== `client.id.split('0.')[0]` and  `"SELECT * FROM app_loc_user WHERE locid=tok.locid AND appid=tok.appid AND userid=tok.userid"` looks for auth as true (pesumably owner of app@loc can click access on and off)
* broker/authorizePublish Same argument as above, 4 kinds of publish.
   1. `case client.id==dev || dev=='presence'`: a) `if(client.id==topic.split('/')[0])` since the client.id of a device is its devid. b) anybody can publish `presence`
   2. `case topic=='cmd' || topic=='prg'`: /dbPublish not OK for `obs` or `any` roles
   3. `case topic=='set'`: /dbSet `"SELECT * FROM app_loc_user WHERE locid=tok.locid AND userid=tok.emailid AND appid=tok.appid and role= 'admin'"`

This will probably fuck up builder and installer (and hvac and timr but who cares). `app_loc` becomes increasingly important. 

* soauth: any records from a query to `app_loc_user` indicate to soauth that yes you are who you say you are and yes we should tell signin that you are good to go since there is at least one location for this appid/user
* signin: The callback comes back to #registered and
   1. if there is a message then registered shows a shit outa luck message otherwise
   2. put the token in ls and route to /#locs then fetch the locations/apps from expres. On click on a location switch to /#apps/:loc.
   3. Clicking on a app@loc fetches a new token that the app can use. It will have appid,locid & userid in it and be saved in ls as appid:{emailid, token:blaslldldl}. Now signin is done and it routes you to the app you selected
* an_app: 
   1. check the local storage for a record else return to signin or on success
   2. fetch the app_loc information for the app@location.  Now you have devs and zones info to work with. Now you can...
   3. Set up paho mqqt. 
      * `client = new Paho.MQTT.Client(cfg.url.mqtt_server, cfg.url.mqtt_port, cfg.appid+Math.random()`
      * `connect({... userName: emailid, password: token})`
      * map over the devices used for the app@location. 
         1. `onConnect()` subscribe, and `publish(req, '{"id":0,"req":"srstates"}')` + whatever other req's you need to make.
         2. All the devices/topics subscribed to and shit that the app publishes to those devices share (hopefully) the username/emailid and password/token.
      * Everything works display a /#frontpage like hvac.parleyvale and link it live to the data
      * click on a deviceunit zone and goto /zone/:azone
      * /zone/:azone goves you ways to temporarily boost or modify a program with a hold or an insertion and lists the prog for the day.
      * /zoneprog/:azone prog every day for that zone
      * /shareprogs lets you copy a zones prog to tother zones
      * /allprogs tell you wwhats up for the whole location

edge cases:

signin: 
1. if no ls token goto /#register and tell them to register
1. if you start on signin/locs or signin/apps/:loc and no token got /#register
2. If callback to /#registered has message tell thenm shit outa luck
2. If callback has token you are not in an edge case.

an_app:
1. anytime there is no token in ls send them back to a /signin with a message on where they came from and that htey need to re-register


soauth
* express/reg/auth `'SELECT * FROM user_app_loc  WHERE userid = ? AND appid = ?'` any returned record means this user is authorized for this app somewhere

broker
* broker/authenticate/dbAuth(device) `"SELECT devid, devpwd, owner FROM devs WHERE devid=?"` checks for match to depwd and devid
* broker/authenticate/dbAuth(appid.random) `if(tokdata.appId==clientid && tokdata.email==username)` no db callunless anybody
* broker/authorizeSubsribe/dbSubscr `winp = [dev,appId,client.user]` gets appid from `client.id.split('0.')[0]`,userid from client.user, devid from `topic.split('/')[0]  "SELECT * FROM user_app_loc WHERE devid=? AND appid=? AND userid=?"` and looks for auth as true(pesumably owner of app@loc can click access on and off)
* broker/authorizeSubsribe/dbPublish `winp = [dev,appId,client.user]` gets appid from `client.id.split('0.')[0]`,userid from client.user, devid from `topic.split('/')[0]  "SELECT * FROM user_app_loc WHERE devid=? AND appid=? AND userid=?"` and looks for role not `obs` or `any` (should probably check auth too)

# overall iot summary

## social-auth

1. spa(single page app) sends string to soauth api which includes appid, cb/referrer_url, api_url (but not email).
2. /spa/:appid gets string puts it in appinfo and mongo and shows the index.ejs (gmail, facebook, github...)
3. some kind of registration magic happens resulting in the production of an apikey containing the verified emailid and the appid
4. that apikey gets sent to the api's /reg/auth which says yes you got some shit goin on here or no we don't know you
5. if auth api's auth is true then that apikey (email/appid) is sent back to the spa else a 'shit outa luck message
6. That apikey gets stored on the spa's local storage and used as the bearer token in calls to the api

### provisos
If the register call is decided to be from a shared signin then the apikey will have emailid and the appid=`signup`. So say if signup got your locs and apps at those locs then maybe it should somehow send bac an apikey that's good for at least emailid/appid of the app you have chosen.

## iotb v2.0
1. An mqqt client is created on the spa on startup/first load. It creates the appid+random_number. Nothing happens it is just declared.
2. When the device is selected in appoj/Paho2, it runs connect() which connects saying ssl=true and sening usename and the token(emailid/appid). It know nothing about the device at this point. The broker, however, authenticates anyway.
3. dbAuth gets the clientid, username and passowrd.
   * if it a device trying to authenticate then the clientid is the deviceid(CYURD..), the username is the device's owner and the password is device password `geniot`. **_the db table queried is the pretty bulky `devs` table._**
   * If it is an websocket app trying to authenticate then the clientid is the appid+random, and the password is a token(emailid/appid). All dbAuth does here is check that the username matches token.userid and the appid.split('0)[0] matches token.appid. **_SO THE TOKEN CAN'T BE STHE SAME TOKEN SENT IN SIGNIN_**
   * * (if username='anybody) it does a db lookup on `user_app_loc`
4. The spa after announcing its presence starts subscibing to deviceid's and topics with a syntax like `client.subscribe('CYURD001/srstate')`. iotb takes that and runs it through `moserver.authorizeSubscribe = authorizeSubscribe(client, topic, callback);` where client is the client.user=emailid client.id=devid+random, topic=device/topic
5. dbSubscr uses devid, appid and useid gets selected for whether `auth` = 1 or not. and ifso it OK's the subscription to the device for all of its topics. Now data can start rolling in from a device.
6. A similar operation happens for authorizing publish but this time it happens every time you try to publish. dpPublish only looks at the role. if it is `obs` or `any` than it won't let you publish

### what I learned here
If we move toward a signin/loc/app spa callin whatever the app spa is than that spa will need a token with its appid not `signup`. So whenever the call looking for a users@loc apps, it will need to return new tokens which then get put into local storage. Maybe at the same time it should get the list of the devices that are used by that app at that device. maybe also the loc id too. ls would look like hvac:{emailid:tim@sitebuilt.net, loc:12ParleyVale, devs:[CYURD003, CYURD023], token:xxemailidxxappid}. That token would allow you to connect to the broker (not to any specific device)

### table fields needed
    already written
* dbAuth(app) needs: NOTHING (token&token.email)
* dbAuth(dev) needs devid, pwd, owner
* dbSubscr needs: devid, appid, userid, auth
* dbPublish needs: devid, appid, emailid, role
* reg/auth needs: emailid, appid, auth

    signin
* emailid, location, apps

    hvac
* location, devs, zones, emailid, app


express
* whatever it does need regrooving

# refs
http://blog.pingzhang.io/javascript/2016/09/22/passport-facebook/
https://stackoverflow.com/questions/15513427/can-the-callback-for-facebook-pasport-be-dynamically-constructed
# deploy
OK 

it seems that http://162.217.250.109:7080 lets http%3A%2F%2F71.192.254.240%3A3332%2Fapi through but https://services.sitebuilt.net/soath doesn't

copy apps,views,README,server.js,env.json,package.json in ./deploy.sh

    #!/bin/sh
    server=sitebuilt.net
    path=/home/services/social-auth
    echo $server:$path
    scp package.json root@$server:$path
    scp env.json root@$server:$path
    scp README.md root@$server:$path
    scp server.js root@$server:$path
    scp appid root@$server:$path
    scp -r app root@$server:$path/app
    scp -r views root@$server:$path/views

try node server then npm install --save x until it runs. copy package.json back

add to /etc/nginx/sites-available/services

    location /soauth/ {
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-NginX-Proxy true;
        proxy_pass http://localhost:7080/;
        proxy_ssl_session_reuse off;
        proxy_set_header Host $http_host;
        proxy_cache_bypass $http_upgrade;
        proxy_redirect off; 
    }
then `systemctl reload nginx`

try running as `http://162.217.250.109:7080`

http://162.217.250.109:7080/spa/tauth/http%3A%2F%2F10.0.1.102%3A3332

http://162.217.250.109:7080/login/Fiyorusohefetejacowinite/tim@sitebuilt.net/tauth

get local signup running
duplicate admin as admind and change url.souath as http://162.217.250.109:7080


# tags
## 06
## 05-jwt-to-spa&api-devuserapp-table
Before redirecting back to spa/registered, post a jwt to /api/auth which decodes it and then saves it to devuserapp  mysql table in geniot database and send the jwt to the spa
## 04-local
local is done and handles appId correctly
## 03-redirect-to-from-app
If multiple people were registering at the saem time it could fuck up
### question - How to pass an additional parameter to passport.authenticate
Actually it didn't work

    passport.use(new FacebookStrategy(fbStrategy,
            function(req, token, refreshToken, profile, done) {
            console.log(req._toParam);

comes back as undefined even though it is defined here..

    app.get('/auth/facebook/:appId', function(req,res,next){
      req._toParam=req.params.appId
      console.log(req._toParam)            


http://stackoverflow.com/questions/43265992/how-to-pass-an-additional-parameter-to-passport-authenticate

(I already do `fbStrategy.passReqToCallback = true` ) I am riffing off 
https://scotch.io/tutorials/easy-node-authentication-linking-all-accounts-together but want to use this social authentication service for multiple apps, ex: the one that controls the heating system, the one that turns on the sprinklers etc.

Basically if one of these apps checks with the server and doesn't have a correct token it get redirected to this social authentication service (social-auth). When the user presses on of the social login buttons it grabs the parameter of what app its arriving from and adds it as a parameter for `/auth/facebook/:appid`

        // send to facebook to do the authentication
        app.get('/auth/facebook/:appId', function(req,res,next){
            passport.authenticate(
                'facebook', { scope : 'email' }
            )(req,res,next);
        });

`req` of `req,res,next` is the serialized user record. At this point social-auth doesn't know who the user is. 


    fbStrategy.passReqToCallback = true;  
    passport.use(new FacebookStrategy(fbStrategy,
        function(req, token, refreshToken, profile, done) {
            var email = (profile.emails[0].value || '').toLowerCase()     
            process.nextTick(function() {...

Once authorization is complete I want to redirect back to the calling app and I need the `:appId` param to ride along so I can go back to the right site.

Now generally it would work if I just made a variable like `currentAppId` accessible to the various social stategies but If you happened to have multiple people authenticating at the same time then you conceivably have a user return to the wrong app, or some other users app. That's why I need `appId` to travel as param to `passport.authenticate` . Where should I be looking to figure out how. Could I wrap `passport.authenticate` or otherwise modify things?

- https://code.tutsplus.com/articles/social-authentication-for-nodejs-apps-with-passport--cms-21618
- https://scotch.io/tutorials/easy-node-authentication-linking-all-accounts-together
- https://developers.facebook.com/docs/facebook-login/manually-build-a-login-flow


- https://developers.facebook.com/apps/263878937398656/fb-login/
- https://apps.twitter.com/app/13521887/keys
- https://github.com/settings/developers
- https://console.developers.google.com/apis/credentials/oauthclient/574383590213-1vfblbifa1lv2oalq2jl5mcvfklcs8lo.apps.googleusercontent.com?project=sb-logintest

Now that I've convinced myself that a CORS rest api for authentication is not in the cards <s>services/social-jwt-stateless</s> and that some networks like twitter and linkedin are still on Oauth1.1 and can't authenticate from a javascript front end, I am on the trail of having two backends, one to handle social authentication and another for the actual CORS friendly api serving a SPA. So then there would also be two front ends made to look as one. 

A user opens an SPA and if there is not a current, valid JWT token in localStorage or if the token (which travels on every request to the server) is expired or invalid then the SPA redirects to the the social-auth server which offers login choices from its server delivered pages. 

Now all the OATH calls to the social network and callbacks from them occur ending up with an authenticated user with an email address (used as a primary key), name, soc.token etc., in short everything OATH needs to determine if the user is valid, or needs to re-login. The end result is that some user is authenticated. social-auth then sends the pertinant info to the SPA's api as a JWT encoding an email and expiration.  

Once a user authenticates by some social network and the social-auth authentication server has sent its token the api forwards it (or a new/different JWT) to the SPA

Now all is good. The SPA sees what it is allowed to see for that user and can interact with the backend api.

If the SPA token goes away then the app redirects to social-auth and the process repeats.

?? Should social-auth keep track of which apps a user is using it for ??
?? Would it work for as the authorizer for multiple apps??

## 00-initial-commit
starting with Code for the entire scotch.io tutorial series: Complete Guide to Node Authentication  www/crowd/node-authentication-guide, 

- moved auth.js and database.js into env.json.
- to get email from twitter, created privacy and terms of service pages, included `userProfileURL` and `includeEmail` in the Twitter Strategy and in `https://apps.twitter.com/app/13521887/permissions` added the permission `Request email addresses from users`
- added github to the ejs pages, routes, env and passport strategy.

## 01-change-data-model
changed

- /config/passport.js
- /app/routes.js

<s>TODO</s>s>
the database is still a mess needs to be associated with email address as the key, and maybe a field with app names and tokens that are using this social-auth service per email key.

if profile
    get email
    find email if err return done(err)
    if email
        if !facebook add a facebook user for that email 
        else if !facebook.token
            if facebook id = profile.id               
                add token to user return 
            else replace entire facebook entry return
        return done(null,user)
    else create user           

## 02-local-appid
### appid


A call to social-auth will look something like get`http://127.0.0.1:7080/?appid=duck&appapi=https://services.sitebuilt.net/cascada`. or post The route will check if the app is registered else it will add it. 

Maybe there will have to be some general token key that all app that use social-auth will need.

- [x]
`{
    appId: 'duck',
    appApi: 'https://services.sitebuilt.net/cascada',
    appRedirect: https://cascada.sitebuilt.net,
    appKey:  'dlkdlkrleklrkelkr'
}`

Maybe the SPA just sends and appid and an api route. All api's who use social-auth must have the jwt.secret for social-auth and all its apps. You get it when the app is entered into the app database. You get it by calling the api route with a jwt made by secret encoding the appid. The api returns the appRedirect and a new appkey token. Both get stored in the app database.


### any signup 
Any signup will result in the creation of a token that encodes
`{
    email: userinfo.emailkey,
    appid: appid,
    exp: '90'days'
}`
So the last step of the Strategy would be to send that token to the api and redirect to the SPA. You don't need to keep a copy anywhere since if the SPA loses its token it just redirects to`http://127.0.0.1:7080/?appid=duck&appapi=https://services.sitebuilt.net/cascada`

So the api gets sent a tokenized user and accepts it because social-auth has included the bearer appkey token.

Any auth will also put the appid in the list of apps for that user

### local signup

if email

- [] register an appid
- [] 

# IOTexpress
express part of what used to be geniot
## todo

redo bearer strategy as middleware, chuck passport.
possible messages from bearerToken(req, res, next)

req.tokenAuth =
{auth: false, message: 'token expired'}
{auth: false, message: 'token defective'}
{auth: false, message: 'no user'}
{auth: true, message: 'user has apps', apps:{}}
{auth: true, message: 'user has no apps'}

Bearer strategy should return all the devuserapp records for an email address or if none the failure

* What should be in the user database?
* What should be in the device data file?
* relational or object?

* each device can rum one o0r more apps
* each user controlls certain devices
* device owner decides who can veiw, modify or admin each of its devidces
* device has  devid, devpwd, owner, location, timezone, server:port, sensor type, apps: [{appId, users:[{user, priveledges}]}]
* user has email and devices: [{devid, apps:[appid, auth:true/false, priveledge]}]

* user goes to iot portal and after authenticating is shown a list of devices and apps they are registered for.
* owner invites a user to use a device and (some/all of its) apps by email linkto iot portal
* there is an owner/admin page where you can register a device and add users for its apps
* super declared in env.json
* if registered is super then goto superapp  