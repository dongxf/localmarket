Future = Npm.require('fibers/future');

Meteor.methods(
  validateEmailAddress: (address)->
    check(address,String)
    validateEmail = new Future()
    HTTP.call("GET", "https://api.kickbox.io/v1/verify",
      params:
        email: address
        apikey: "53b94aa4370bdd869c74037c29ed00ebc3418fb57cf79095a11ce3d3fc90341b"
    , (error,response)->
      if error
        validateEmail.return(error)
      else
        if response.data.result == "invalid" or response.data.result == "unknown"
          validateEmail.return( error: "对不起该邮箱无法投递,请重新提供有效的邮件地址")
        else
          validateEmail.return(true)
    )
    validateEmail.wait()
  ifEmailUsed: (email)->
    #Meteor.users.find({ "emails.address" : 'f...@foo.com' });
    #Meteor.users.find({emails: {$elemMatch: {address: "f...@foo.com"}}})
    if Meteor.users.find({"emails.address": email}, {limit: 1}).count() > 0
      return true
    else
      return false
      #throw new Meteor.Error(404, "未找到");
    ###send sms
    url="http://tui3.com/api/send/?k=d98784f3ec44bb34b93488968bed81d7&r=json&p=1&t=18991166667&c="+msg
    url='http://tui3.com/api/send/?k=d98784f3ec44bb34b93488968bed81d7&r=json&p=1&t=18991166667&c=您的验证码是1234，感谢您注册丰巢优选'
    var result = Meteor.http.get(url,{timeout:3000});
    ###
)
