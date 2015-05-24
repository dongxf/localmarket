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
  'click .js-login': ->
    email=$('[name="emailAddress"]').val()
    password=$('[name="password"]').val()
    Meteor.loginWithPassword(email, password, (error)->
      if error
        alert error.reason
    )
)

# Rendered
###
Template.signInWithEmail.rendered = ->
  $('#sign-in-with-email').validate(
    rules:
      emailAddress:
        required: true
        email: true
      password:
        required: true
    messages:
      emailAddress:
        required: "Gonna need an email, there, friend!"
        email: "Is that a real email? What a trickster!"
      password:
        required: "Pop in a passwordarooni for me there, will ya?"
    submitHandler: ->
      # Once our validation passes, we need to make a decision on
      # whether we want to sign the user up, or, log them in. To do
      # this, we look at a session variable `createOrSignIn` to
      # see which path to take. This is set below in our event handler.
      createOrSignIn = Session.get 'createOrSignIn'
      alert(createOrSignIn);

      # Get our user's information before we test as we'll use the same
      # information for both our account creation and sign in.
      user =
        email: $('[name="emailAddress"]').val()
        password: $('[name="password"]').val()

      # Take the correct path according to what the user clicked and
      # our session variable is equal to.
      if createOrSignIn == "create"
        # Before we do the insert, we call to the server to validate our email
        # address. This isn't *required*, but it's a good feature to have. This
        # allows us to ensure that users are signing up with legitimate email
        # addresses and not addresses that will bounce.
        Meteor.call 'validateEmailAddress', user.email, (error,response)->
          if error
            # If we get an error, let our user know.
            alert error.reason
          else
            if response.error
              # If we get an error from our method, alert to the user.
              alert response.error
            else
              # If all is well, create the user's account!
              Accounts.createUser(user, (error)->
                if error
                  alert error.reason
                else
                  # If all works as expected, we need to hide our modal backdrop (lol, Bootstrap).
                  $('.modal-backdrop').hide()
              )
      else
        Meteor.loginWithPassword(user.email, user.password, (error)->
          if error
            alert error.reason
          else
            # If all works as expected, we need to hide our modal backdrop (lol, Bootstrap).
            $('.modal-backdrop').hide()
        )
  )
###

###
submitHandler: ->
  createOrSignIn = Session.get 'createOrSignIn'
  user = 
    email: $('[name="emailAddress"]').val()
    password: $('[name="password"]').val()
  if createOrSignIn == "create"
    Meteor.call 'validateEmailAddress', user.email, (error, response)->
      # We'll handle any errors anc create the user account here
      if error
        alert error.reason
      else
        if response.error
          alert response.error
        else
          Accounts.createUser(user, (error)->
            if error
              alert error.reason
            else
              $('.modal-backdrop').hide()
          )
  else
    Meteor.loginWithPassword( user.email, user.password, (error)->
      if error
        alert error.reason
      else
        $('.modal-backdrop').hide()
    )
###
