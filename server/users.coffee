Accounts.onCreateUser((options, user)->
  # If this is the first user going into the database, make them an admin
  if Meteor.users.find().count() == 0
    user.admin = true

  userData = 
    email: determineEmail(user)
    name: if options.profile  then options.profile.name else ""

  if userData.email != null
    Meteor.call 'sendWelcomeEmail', userData, (error)->
      console.log error if error

  if (options.profile)
    user.profile = options.profile

  return user
)

determineEmail = (user)->
  if user.emails
    emailAddress = user.emails[0].address
  else if user.services
    services = user.services
    emailAddress = switch
      when services.github then services.github.email
      when services.google then services.google.email
      when services.facebook then services.facebook.email
      when services.weibo then null
      when service.twitter then null
      else null
  else
    null

Meteor.methods(
  sendWelcomeEmail: (userData)->
    check(userData,{email: String, name: String})
    SSR.compileTemplate('welcomeEmail', Assets.getText('email/welcome-email.html'))
    emailTemplate = SSR.render('welcomeEmail',
      email: userData.email
      name: if userData.name != "" then userData.name else null
      url: "http://trust.fooways.com"
    )
    sendEmail( userData.email,"欢迎进驻丰巢，您的放心食品采购和健康食谱交流社区",emailTemplate)
)

