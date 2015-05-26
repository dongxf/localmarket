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
    $('#social-tips').text('>>微博登录中，请稍候<<');
    Meteor.loginWithWeibo(
      loginStyle: 'redirect'
    )
  'click .js-twitter': ->
    $('#social-tips').text('>>翻墙后才可用<<');
  'click .js-wechat': ->
    $('#social-tips').text('>>正在努力开发<<');
  'click .js-signin': ->
    email=$('[name="emailAddress"]').val()
    password=$('[name="password"]').val()
    Meteor.call 'ifEmailUsed', email, (error,response)->
      $('#social-tips').text '邮件较验中，请稍候'
      if error
        $('#social-tips').text error.reason
      else
        if response
          $('#social-tips').text '安全登录中，请稍候'
          Meteor.loginWithPassword(email, password, (error, response)->
            $('#social-tips').text error.reason
          )
        else
          user =
            email: email
            password: password
          $('#social-tips').text '邮件验证中，请稍候'
          Meteor.call 'validateEmailAddress', user.email, (error,response)->
            if error
              $('#social-tips').text error.reason
            else
              if response.error
                $('#social-tips').text response.error
              else
                # If all is well, create the user's account!
                Accounts.createUser(user, (error)->
                  if error
                    $('#social-tips').text error.reason
                )
)
