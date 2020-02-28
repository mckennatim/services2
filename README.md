# services
## tags
https://cloudinary.com/console/welcome

### timecards-2020-wh
https://www.irs.gov/pub/irs-prior/p15t--2020.pdf

https://www.mass.gov/doc/massachusetts-circular-m-income-tax-withholding-tables-at-50-effective-january-1-2020/download

### 59-timecards-yearend

https://secure.ssa.gov/apps12z/EWRHome/AttestView.action submitted on 2/26/20 ck back

### 58-timecards-getw2
prints w2's

https://www.base64-image.de/

### 57-timecards-efw2
https://mtc.dor.state.ma.us/mtc/_/

https://www.mass.gov/doc/w-2-electronic-filing-specifications-handbook/download

https://www.realtaxtools.com/state-w2-efile-frequently-asked-questions/Massachusetts.html

### 56-tmecards-ra

### 55-timecards-payroll

### 54-timecards-scratch.sql
pulled data from gl for w2 and efw2
https://www.ssa.gov/employer/EFW2%26EFW2C.htm

### 53-timecards-signup-payroll
maybe location of stuff is bad

### 52-timecards-payroll-cosr-fedr-fedwh-strates

### 51-timecards-persons-scratch
added multiline queries to env. persons has /current that will probably never be used but scratch has a multiline that is almost enough info to write checks with

        /**query to get current persons and rates for approved tcardwks***/
        DROP TABLE IF EXISTS `timecards`.`cureff` ;

        CREATE TABLE `timecards`.`cureff`
        SELECT p.emailid , MAX(p.effective) AS curedate
        FROM `timecards`.`persons` p
        WHERE effective < CURDATE()
        AND p.coid ='reroo'
        GROUP BY p.emailid;

        DROP TABLE IF EXISTS `timecards`.`cureffective` ;

        CREATE TABLE `timecards`.`cureffective`
        SELECT p.*
        FROM `timecards`.`cureff` c
        JOIN  `timecards`.`persons` p
        ON c.emailid=p.emailid 
        AND c.curedate=p.effective;

        SELECT t.*, c.*
        FROM `timecards`.`tcardwk` t
        JOIN `timecards`.`cureffective` c
        ON  c.emailid = t.emailid
        WHERE t.status='approved'
        AND t.coid= 'reroo';

approved tcardwks with current rate records from persons        

### 50-timecards-tcard-updated
### 49-timecards-coid-in-tokData
### 48-timecards-regtokau-strategy
### 47-reroox.9-jobs-beta0.4
### 46-reroox.8-jobs-beta0.0
### 45-reroox.6-tcard-maybedone
TODO except for status
### 44-reroox.5-tcard-addpadwk
combinPuJc now creates a blank week padded with a weeks punch and jcost. inout hours are summed.
### 43-reroox.5a-tcard

Ok so now get (a week), put (a day), and delete(a day) all work

This is now what comes from the database, The server combines the results of tcardpu and tcardjsc into records for each day of the week that there is tcardpu data. If there is no tcardpu data but there is tcardjc data then it will leave that data on the server and return [].



    parr:  
    { wkarr:
      [ { wdprt: '2018-W34-5',
          hrs: 0,
          inout: [],
          jcost: [],
          jchrs: 0,
          idx: 0 },
        { wdprt: '2018-W35-1',
          hrs: 8.25,
          inout: '["7:30", "15:45"]',
          jcost: [Array],
          jchrs: 8.25,
          idx: 1 },
        { wdprt: '2018-W35-2',
          hrs: 8.5,
          inout: '["7:15", "15:45"]',
          jcost: [Array],
          jchrs: 8.5,
          idx: 2 },
        { wdprt: '2018-W35-3',
          hrs: 0,
          inout: [],
          jcost: [],
          jchrs: 0,
          idx: 3 },
        { wdprt: '2018-W35-4',
          hrs: 7.25,
          inout: '["8:30", "15:45"]',
          jcost: [Array],
          jchrs: 7.25,
          idx: 4 },
        { wdprt: '2018-W34-6',
          hrs: 0,
          inout: [],
          jcost: [],
          jchrs: 0,
          idx: 5 },
        { wdprt: '2018-W34-7',
          hrs: 0,
          inout: [],
          jcost: [],
          jchrs: 0,
          idx: 6 } ],
      hrs: [ 8.25, 8.5, 7.25, 9.5 ],
      jchrs: [ 8.25, 8.5, 7.25, 9.5 ] }
### 42-revoox.4-jobs-crud
crud for app AddJobs and SortJobs
### 41-revoox.3-coid
#### On a vexing problem of generaliztion
Currently emailid and appid is the level of identification offered by soauth and the associated api. What if you wanted to have multiple companies using these apps? You could just encode the company in env.json and that will have to do for now. The problem rears itself when you have an emailid and appid used by more than one company. 

<s>Possibly `bearerTokenApp` has access to params and can then return a single record for emailid, appid, coid </s>

SOLUTION: encode extra data in the appid part if the registration string. Get if from cfg and concatenate it like `reroo-jobs`. In soauth the data gets encrypted in the apikey And then on auth it is compared to whats in `whoapp`.

If all that works out it comes back to the spa app as an token which from then on gets sent out as a bearers token inside every page req. That `bearerTokenApp` slips some data (coid,appid,email) back to the route in req.tokData which can then inform those queries in terms of who and for what comppany.

### 40-reroox
todo /jobs/post/wk probably usiing delete and insert
minor updates of coid, 
### 39-reroox
made it work with the reroox api. There was a problem in routes:211 with the url for the email link not working.

          var baseURL = req.protocol+"s://"+req.headers.host+cfg.base
          //var baseURL = req.headers.origin+cfg.base

social auth verifies your identity then checks with the app's api to see if you are allowed to play. The route `app.use('/api/reg', regtokau);` now looks in the reroo.whoapp for api/reg/auth for a match and sets the `auth` field for emailid+appid. 

In this case it is the `jobs` appid. Not taken into account is the `coid`. that you woud need to deal with to generalize this for other companies.

server for restoring roots

reroox/sql

what happens in authentication?

1. social auth gets a api url in the params after you press the register button
2. once you prove you are who you are soical auth queries the apps api to see if you are listed among the valid users of that app.

mysqldump -uroot -pthepass --opt reroo > reroo.sql

### 38-express2.0d-admin
### 37-express2.0c-index-post-scheds
post a whole week of scheds
### 36-broker2.0e-setTimeAndSched
https://stackoverflow.com/questions/7745609/sql-select-only-rows-with-max-value-on-a-column
Some cool SQL added to some code to combineScheds() on the day the hold is over. The hold ends at a time at which point the normal schedule for that day resumes.

    const combineScheds=(holdsched, resumesched, daymin)=>{
      let holdarr = JSON.parse(holdsched)
      let resuarr = JSON.parse(resumesched)
      let hrmin = daymin.split(':')
      let hr=hrmin[0]*1
      let min =hrmin[1]*1
      let srdlen=holdarr[0].length - 2
      let res= holdarr.slice()
      resuarr.map((prg,i)=>{
        if(prg[0]==hr){
          let np = [hr, min].concat(prg.slice(-srdlen))
          res.push(np)
        }else if(prg[0]>hr){
          let tmp = resuarr[i-1]
          if (tmp[0]<hr){
            tmp[0]=hr
            tmp[1]=min
            res.push(tmp)
          }
          res.push(prg)
        }
      })
      let resstr = JSON.stringify(res)
      return resstr
    }

#### greatest-n-per-group.
All tests are in IOTbroker2.0/tests/atest.spec.js. Just run `mocha`

my.getTodaysSched

    SELECT * FROM scheds 
    WHERE (devid,senrel,dow) 
    IN ( 
      SELECT devid, senrel, MAX(dow) 
      FROM scheds 
      WHERE (dow=0 OR dow=1 OR dow=8) 
      AND (until = '0000-00-00 00:00' OR '2018-03-12' <= until) 
      GROUP BY devid, senrel 
      ) 
    AND devid = 'CYURD001' 

Device gets the schedule every day by calling `my.grtTodyasSched` which searches for the schedule with the `max dow` It doesn't work yet.

Should return a the appropriate schedule record for each senrel of a device. 

Inserting  a hold should look something like this

    INSERT INTO scheds
    SET 
    `devid` = 'CYURD001',
    `senrel` = 0,
    `dow` = 8,
    `sched` = '[[0,0,55,53]]',
    `until` = '2018-06-02 10:15'
    ON DUPLICATE KEY
    UPDATE 
    `devid` = 'CYURD001',
    `senrel` = 0,
    `dow` = 8,
    `sched` = '[[0,0,55,53]]',
    `until` = '2018-06-02 10:15'

### 35-broker2.0d-sched.setTimAndSched
cleaned up and replaced getTime.

Holds are now incorporated into the sched table and queries.

Its the day the hold is over. Move in the schedule that will come back into force now that the hold is done. Figuring that the day started with the hold still in play, start with the hold array. Push on all the regularly scheduled progs that start after after the hold is over. But before that... If there is a regularly scheduled prog for the hold end hour, replace its hours and minutes. For the regularly scheduled prog that would have been running before the hold ends, plug in the latter start time of the hold so it can start to run as soon as the hold is over. 

    let srdlen=holdarr[0].length - 2
    let res= holdarr.slice()
    resuarr.map((prg,i)=>{
      if(prg[0]==hr){
        let np = [hr, min].concat(prg.slice(-srdlen))
        res.push(np)
      }else if(prg[0]>hr){
        let tmp = resuarr[i-1]
        if (tmp[0]<hr){
          tmp[0]=hr
          tmp[1]=min
          res.push(tmp)
        }
        res.push(prg)
      }
    })
### 34-after-broker2.0c
TODO need to final mod my.getTodaysSched to incorporate holds
TODO implement sched.modSchedIfHoldEndsToday

testing mocha now using mocha-clean and npm run test in IOTbroker2.0. reformulating processMessage getTime to gettimeandsched. Need to have sendsSched use the mapping as in sched.js:132
### 33-exprss-test-mysql-2.0b
starting to think about changing both to get holds 
### 32-IOTexpess-broker-2.0
Normalized databases are in place and queries have been written for version 2.0
### 31-recording-srstate
Recording srstate data take place on a cassandra cluster via iotb.index.js.processIncoming.srstate cassClient.execute(q1). Reco.count is a mongo query which stores which dev/senrels are currently being recorded.
### 30-dow-programs
iotex handles saving a program through dedata/prg but iotb is the server that loads the current programs for each device into the device on every timecheck

Avoiding the now working publish callback, so moved sched.js.getTime.my.getTodaysSchedule out of the sched.js.getTime.mosca.publish 
#### question
I'm running mosca: 2.3.0 and wanted to do some work in the service publish callback but it never seems to fire even though the message gets delivered. Here I just published a simple message after mosca is ready but console.log('done! SUPER SIMPLE') never runs.  Any ideas?

    moserver.on('ready', setup);

    function setup() {
      console.log('Mosca server is up and running')
      console.log('device mqtt running on port '+cfg.port.mqtt)
      console.log('browser mqtt over ws port '+cfg.port.ws)
      var message = {
        topic: '/hello/world',
        payload: 'abcde', // or a Buffer
        qos: 0, // 0, 1, or 2
        retain: false // or true
      };
      moserver.publish(message, function() {
        console.log('done! SUPER SIMPLE');
      });  
    }
#### answer
Actually the callback works on a new simple server, Something is fucking with it in the code I wrote. 
### 29-iotb-intercepts-user-messages
and tells you if they can publish, 
### 28-iotb-notpubAuthorizeddisconnects
### 27-iotb-publishAuthorized
Right now it lets everyone publish but the nuts and bolts are almost in place.

    SELECT * FROM devuserapp WHERE devid='CYURD001' AND appid='pahoRawSB' AND userid='tim@sitebuilt.net' 

This should return a role for that user for that app on that device. Then `mysqldb.js/dbBublish` should be able to a) make sure there is an entry, b)check if the role listed is `user` or `admin`. If anybody can view an app than there should be an `anybody` user with `obs` role. Register has to be jiggered so that's OK.

TODO move cascada over to api2
### 26-mosca-problem
https://www.bountysource.com/issues/41088112-client-connection-closed-if-publish-is-not-authorized

also..
IOTexpress got modified to add `get dedata/users/:devid` and `post dedata/users`
### 25-iotex-dedata-users
### 24-iotex-get-apps
dedata/apps query changed to only get admin and super appids
#### On recording senrel data
To record or stop recording a sensor or relay 
1. you make a post/delete to iotex/api/dedata/rec with a body that looks like `{id:"CYURD001:1}`
2. the express router iotex/api/dedata/rec makes a mongoose database call `Reco.update` or `Reco.remove` which uses mongo/demiot/recos and adds/updates/removes that id.
3. Now, in `IOTbrokey/index.js` whenever a packet comes in `moserver.published` runs `mq.selectAction(packet.topic)` to find the devices and job and then `mq.processIncoming(packet.payload)` . If the job is `srstate` and `payload.new=true`(the data is new, not just a request for a copy(inside device C code)) then it does a quick check for devid:id in mongo/recos and if it is there the data for that sensor is saved to cassandra.

#### On using stored programs
In order to use programs with these devices one must:
1. save a program the client must make a post to `IOTexpress/api/dedata/prg` with a body like this: `{"devid":"CYURD001","dow":4,"senrel":2,"sched":"[[12,20,77,75]]" }`
2. The program is saved to mysql/geniot/sched.
3. 

### 23-deplay-api2
1. copy mysql
2. copy mongo -no
3. redeploy social-auth - from sitebuilt.net/services/social-auth `rm -r *` `mkdir app views`. From wamp64/www/services/social-auth `./deploy.sh`
4. deploy IOTexpress - ./deploy.sh in wamp64/www/services/IOTexpress
5. deploy IOTbroker - ./deploy.sh in wamp64/www/services/IOTbroker
### 22-servers-almost-done
no frontend yet for post and remove recorder (dome in mysql,spec.js)

summary of database stuff

https://blog.serverdensity.com/checking-if-a-document-exists-mongodb-slow-findone-vs-find/

mongodb
* mosca for internal use
* social-auth soauth for users and apps
* IOTbroker for checking if srstates should be saved (quick read of mong.demiot.recos {id:"CYURD001:0"}
* IOTexpress `dedata/index.js` `/dedata/rec` for posting mongo.demiot.recos {id:"CYURD001:0"} as to be recorded or delete/remove it 
cassandra
* IOTbroker in index.js:mq.processIncoming/srtate to either `tstat_by_day` or `timr_by_month`
mysql
* IOTexpress `devices` `devuserapps` `dedata/prg scheds`

### 21-cassandra
Cassandra is going to be used for devices and senrels that need their time series data stored. So far, there is a tstat_by_day table and a timr_by_month table

* in sitebuilt and parleyvale but not on iotup.stream
* tested in /services/testservice/cassandra.js. 
* cql experiments in services/IOTbroker/cql.js 
* Config is in /etc/cassandra/cassandra.yaml 
* Use single quotes in WHERE clauses.
* 16.04 didn't need java setup but 14.04 did

https://academy.datastax.com/resources/getting-started-time-series-data-modeling

https://www.digitalocean.com/community/tutorials/how-to-run-a-multi-node-cluster-database-with-cassandra-on-ubuntu-14-04

https://hostpresto.com/community/tutorials/how-to-install-apache-cassandra-on-ubuntu-14-04/

http://www.datastax.com/wp-content/uploads/2012/01/DS_CQL_web.pdf cheat sheet

    cqlsh 162.217.250.109 9042 
    cqlsh>USE geniot;
    cqlsh:geniot>SELECT * FROM tstat_by_day ;
    cqlsh:geniot> truncate timr_by_month ;

You can start Cassandra with sudo service cassandra start and stop it with sudo service cassandra stop. However, normally the service will start automatically. For this reason be sure to stop it if you need to make any configuration changes.
Verify that Cassandra is running by invoking nodetool status from the command line.
The default location of configuration files is /etc/cassandra.
The default location of log and data directories is /var/log/cassandra/ and /var/lib/cassandra.
Start-up options (heap size, etc) can be configured in /etc/default/cassandra.

### 20-store-srstate
For some sensors storing the data would be cool. In https://www.mongodb.com/presentations/mongodb-time-series-data-part-2-analyzing-time-series-data-using-aggregation-framework ~20min in they suggest...

* deviceid:sensorid:timeperiod as _id:  use regular expressions to do a range query. Regex must be left-anchored&case-sensitive /^CYURD001:2:1403/



### 19-dedata-post-prg
Tested in mysql.spec.js and implemented in spas/apoj/rawPaho/utility/saveProg
### 18-getTime-getTodaysSched
Every time you get time you get that days programs too from the mysql scheds table. I think that is the end of using `devid/progs`

    var getTime = function(devid, mosca, cb){
      //var spot="America/Los_Angeles"
      my.dbGetTimezone(devid, function(spot){
          console.log(spot)
          var dow = moment().tz(spot).isoWeekday()
          var nynf = parseInt(moment().tz(spot).format("X"))
          var nyf = moment().tz(spot).format('LLLL')
          var nyz = parseInt(moment().tz(spot).format('Z'))  
          var pkt = {
            unix: nynf,
            LLLL: nyf,
            zone: nyz,
          };    
            console.log(JSON.stringify(pkt))
            var topi = devid+'/devtime'
            var oPacket = {
                topic: topi,
                payload: JSON.stringify(pkt),
                retain: false,
                qos: 0
          };
          console.log(topi) 
          mosca.publish(oPacket, function(){
            console.log('dow is ', dow)
            //var topic = devid+'/prg'
            my.getTodaysSched(devid,dow,function(results){
                results.map((res)=>{
                    cons.log(res)
                    var payload = `{"id":${res.senrel},"pro":${res.sched}}`
                    cons.log(payload)
                        setTimeout(function(){
                            sendSchedule(devid, mosca, payload, (payload)=>{
                                cons.log(payload, ' sent')
                            })
                        }, 1000)                
                })
            })
          });
        })
    }


var sendSchedule= function(devid, mosca, payload, cb){
    var topi = devid+'/prg'
    var oPacket = {
        topic: topi,
        payload: payload,
        retain: false,
        qos: 0
  };
  mosca.publish(oPacket, ()=>{
    cons.log('prg sent')
  });       
} 

### 17-IOTexpress-strategy-handle-no-authorization-header-crash
sched.js now uses my.dbGetTimezone(devid, cb) every time time is checked for device
### 16-IOTexpress-regotoku-IOTbroker-super
fixes super duplicates, and makes super authorized
### 15-added-new-device
both admind and pahoRaw can register
### 14-IOTbroker-authorizePublish
take2
callback true unless topic is prg or cmd


Regarding `authorizePublish` if device its OK. For clients, return false for `cmd` and `prg` when role= `obs` or `any`.
            
    if(res.role=='obs' || res.role=='any'){
        cb(false)
    }

    if(cb){
        callback(null, cb);
    }else{
        if(topic=='cmd' || topic=='prg'){
          callback(null, cb);
        }else{
          callback(null,true)
        }
    }




### 13-IOTbroker-connect-auth
https://github.com/mcollina/mosca/wiki/Authentication-&-Authorization
two types: if client starts with 'CY' then it is a device else client

    const dbAuth = (client, username,password, cb)=>{
        console.log(client.id, username, password)
        if(client.id.substr(0,2)=="CY"){

You can add data to a client but I ended up not using it `(35)client.appId= tokdata.appId` instead I get it from client.id ala `var appId = client.id.split('0.')[0]`. 

For publishing I don't know, to handle observer case maybe just need to block certain topics TBD.

client.connect sends username and token, simple is authenticate, harder is authorize.

For subscribing, if its a device then go ahead subscribe. It ita a client then check for auth in `devuserapp` in `dbPubSub`. 

### 12-IOTexpress-tells-social-auth-no
Where are tables populated from?
In theory..
* unauthorized users can be created by either the superuser or the owner of a device.
* once they log in then they are authorized
* devices are added by the super and given to an owner. At the same time the owner is added to `devuserapp` for that device and each of its apps.
* anybody can try an app and if they are not registered, they can register. When they come back from registering and are authenticated as who they be, if they are not authorized for that app then they won't be able to use it
* putting it another way... `tim@sitebuilt.net` wants to use `pahoRawLo` on the `CYURD007`. `social-auth` enters a record with appid and userid no matter what!!! Is that right??? No, it should only continue with the registration if that user and that app is already registered for some device. If not, `social-auth` should fail!!!  It shouldn't return a token to the spa!!! Spa should deal with it. Maybe spa lets anybody observe the device from that app??? Maybe there is an `observer` role for listed users and an `any` role for anybody to observe???  <s>He can because he is the owner and has had an `devuserapp` record entered for that app and device.</s>

### 11-IOTbroker-dbAuth
broker will authenticate with client.id using username=(owner or user) and passwork=(devpwd or token)
### 10-IOTbroker_IOTexpress-insteadof-geniot
todo-levels of authentication
FIX social-auth so expdays comes from spa app

* you get userName via `authenticate` on connection
* the topic `set` needs to be restricted from all users and can only be published from server
* clients can only subscribe and publish to/from devices in their `devappuser` records
* some clients are only observers and cant change shit. This should be done somehow through the server (they can only req)

dbAuth -two kinds of client.id's, device.id or appid.

* devid.id  uses Devices, database for auth
* appid uses devusersapps for auth


### 09-geniot-bearerToken-dedata/dev+apps
### 08-social-auth-using-cookies
setin /spa/:appid
read in /profile
### 07-social-auth-redploy-w-query-for-facebook


### 06-social-auth-deployed
but
<s>facebook and github have `req.headers.referer` in the callback so you can dig out appId with `mf.parseBetween(req.headers.referer, '/spa/', '?')`. Too bad google and twitter don't have that header.</s> For facebook you can also use the query strategy described here http://blog.pingzhang.io/javascript/2016/09/22/passport-facebook/
https://stackoverflow.com/questions/15513427/can-the-callback-for-facebook-pasport-be-dynamically-constructed

HOORAY deployed as `https://services.sitebuilt.net/soauth` Up on forever, note cd first so all the app redirects work

from sitebuilt.net root/forgone.sh

    fuser -KILL -k -n tcp 7080 # hello
    cd /home/services/social-auth
    export NODE_ENV=production&&forever --uid soauth -a start server.js
    sleep 2

Deals with the fact that facebook and twitter don't need email to register. Decided for the moment not to allow a separate user record with emailid as twitter or facebook userid.

passport can't handle done(err, null) it causes a server fault(500) but it will failure redirect if you use done(null,null). So failure redirects to `cfg.base+message` and which has `res.render(message.ejs, {message: mf.getMessage()` 


### 05-social-auth-deployed-butnotfor-passport
OK fooled around with base path in env.json and package.json. 

* `req.headers.origin` was the only way to get the proper protocol, https:
* pass cfg.base into all the forms so the catch when its souath `%=base %>
signup/`
* added a reverse deploy `copyFromDeploy` for those touchups to the code base that allow you to run multiple services on `https://services.sitebuilt.net`

### 04-social-auth-pre-deploy
ugh
Got rid of passport.use(new ApikeyStrategy)

### 03-geniot-try_catch-middleware
`social-auth` creates a record for a user in devuserapp for the spa that used it. That spa also gets back a token created using the api's secret. 

Since all the heavy lifting and passport stuff has been shuttled of to `social-auth` `modules/regtokau/strategy/bearerToken` just has to intercept a request, grab its token and tell the endware what's up.

#### Middleware 
works like so. Here is what middleware looks like 

    var bearerToken = function(req,res, next){
        ...check token (req.tokenAuth = what's up)
        next()
    }

    router.get('/appsa', bearerToken, function(req,res){
        ... now you can do whatever to the request if req.tokenAuth.auth
        res.jsonp(req.tokenAuth)
    })

It is just like this kind of callback thingy

    router.get('/appsa', function(req,res){
        bearerToken(req,res, function(){
            cons.log(req.tokenAuth)
            res.jsonp(req.tokenAuth)
        })
    })

but cooler

#### try catch
jwt.decode croak on errors like bad or expired tokens so you have to catch them

    try { 
        var tokdata = jwt.decode(toka[1], cfg.secret)
        cons.log(tokdata)
    } catch(e){
        cons.log(e.message)
        req.tokenAuth = {auth: false, message: e.message}
        next()
        return
    } 

## todo
Connnect social-auth to geniot. 