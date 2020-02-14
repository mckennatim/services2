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