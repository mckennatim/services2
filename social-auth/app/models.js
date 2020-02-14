// load the things we need
var mongoose = require('mongoose');
var bcrypt   = require('bcrypt-nodejs');

// define the schema for our user model
var userSchema = mongoose.Schema({
    userinfo        : {
        emailkey    : String,
        tokenkey    : String,
        apps        : [String],
        appInfo     : {},
        appId       : String, 
    },
    local            : {
        apikey     : String,
        auth        :Boolean
    },
    facebook         : {
        id           : String,
        token        : String,
        name         : String
    },
    github         : {
        id           : String,
        token        : String,
        name         : String
    },
    twitter          : {
        id           : String,
        token        : String,
        displayName  : String,
        username     : String,
    },
    google           : {
        id           : String,
        token        : String,
        displayName   : String
    }

});

// generating a hash
userSchema.methods.generateHash = function(password) {
    return bcrypt.hashSync(password, bcrypt.genSaltSync(8), null);
};

// checking if password is valid
userSchema.methods.validPassword = function(password) {
    return bcrypt.compareSync(password, this.local.password);
};

var appSchema = mongoose.Schema({
    appId: String,
    spaURL: String,
    apiURL: String,
    cbPath: String,
    current: Boolean
})

// create the model for uers and app and expose them
module.exports ={
    moUser: mongoose.model('User', userSchema),
    moApp: mongoose.model('App', appSchema)
}