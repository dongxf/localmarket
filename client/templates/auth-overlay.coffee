# If the auth overlay is on the screen but the user is logged in,
# then we have come back from the loginWithTwitter flow,
# and the user has successfully signed in.
#
# We have to use an autorun for this as callbacks get lost in the
#   redirect flow.
Template.authOverlay.onCreated ->
  this.autorun ->
    if Meteor.userId() && Overlay.template() == 'authOverlay'
      Overlay.close();

Template.authOverlay.events(
  'submit form': (e)->
    e.preventDefault()
  'click .js-weibo': ->
    Meteor.loginWithWeibo(
      loginStyle: 'redirect'
    )
  'click .js-create': ->
    Session.set 'createOrSignIn', 'create'
    user =
      email: $('[name="emailAddress"]').val()
      password: $('[name="password"]').val()
    Meteor.call 'validateEmailAddress', user.email, (error,response)->
      if error
        alert error.reason
      else
        if response.error
          alert response.error
        else
          # If all is well, create the user's account!
          Accounts.createUser(user, (error)->
            if error
              alert error.reason
          )
  'click .js-signin': ->
    email=$('[name="emailAddress"]').val()
    password=$('[name="password"]').val()
    Meteor.loginWithPassword(email, password, (error)->
      if error
        alert error.reason
    )
)
