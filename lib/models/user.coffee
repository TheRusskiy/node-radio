"use strict"
mongoose = require("mongoose")
uniqueValidator = require("mongoose-unique-validator")
Schema = mongoose.Schema
crypto = require("crypto")
authTypes = ["github", "twitter", "facebook", "google", "vkontakte"]
SALT_WORK_FACTOR = 10

###
User Schema
###
UserSchema = new Schema(
  nickname:
    type: String
    unique: true
  email:
    type: String
    unique: true
    sparse: true

  role:
    type: String
    default: "user"

  hashedPassword: String
  providers: []
  salt: String
  facebook: {}
  twitter: {}
  github: {}
  vkontakte: {}
  google: {}
  first_name: String
  last_name: String
  avatar_url:
    type: String
#    default: "http://www.gravatar.com/avatar?d=mm"
#  _conferences : [{ type: Schema.ObjectId, ref: 'Conference' }]
)

###
Virtuals
###
UserSchema.virtual("password").set((password) ->
  @_password = password
  @salt = @makeSalt()
  @hashedPassword = @encryptPassword(password)
).get ->
  @_password


# Basic info to identify the current authenticated user in the app
UserSchema.virtual("userInfo").get ->
  nickname: @nickname
  _id: @_id
  role: @role
  providers: @providers


# Public profile information
UserSchema.virtual("profile").get ->
  nickname: @nickname
  role: @role


###
Validations
###
validatePresenceOf = (value) ->
  value and value.length


# Validate empty email
UserSchema.path("email").validate ((email) ->

  # if you are authenticating by any of the oauth strategies, don't validate
  return true  if @providers.length isnt 0
  email.length
), "Email cannot be blank"

# Validate empty password
UserSchema.path("hashedPassword").validate ((hashedPassword) ->

  # if you are authenticating by any of the oauth strategies, don't validate
  return true  if @providers.length isnt 0
  hashedPassword.length
), "Password cannot be blank"

###
Plugins
###
UserSchema.plugin uniqueValidator,
  message: "Value is not unique."


###
Pre-save hook
###
UserSchema.pre "save", (next) ->
  return next()  unless @isNew
  if not validatePresenceOf(@hashedPassword) and @providers.length is 0
    next new Error("Invalid password")
  else
    next()


###
Methods
###
UserSchema.methods = {

  ###
  Authenticate - check if the passwords are the same

  @param {String} plainText
  @return {Boolean}
  @api public
  ###
  authenticate: (plainText) ->
    @encryptPassword(plainText) is @hashedPassword


  ###
  Make salt

  @return {String}
  @api public
  ###
  makeSalt: ->
    crypto.randomBytes(16).toString "base64"


  ###
  Encrypt password

  @param {String} password
  @return {String}
  @api public
  ###
  encryptPassword: (password) ->
    return ""  if not password or not @salt
    salt = new Buffer(@salt, "base64")
    crypto.pbkdf2Sync(password, salt, 10000, 64).toString "base64"
}

mongoose.model "User", UserSchema