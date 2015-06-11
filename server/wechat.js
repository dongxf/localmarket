Meteor.methods({
  'wechatAccessToken': function() {
    if ((Date.now()-Meteor.settings.wechat.updatedAt) > 7100000) {
      var appid = Meteor.settings.wechat.appId;
      //Meteor.settings.wechat.appId;
      var secret = Meteor.settings.wechat.appSecret;
      var url = 'https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=' + appid + '&secret=' + secret;
      var result = Meteor.http.get(url, {timeout: 3000});
      if (result.statusCode == 200) {
        Meteor.settings.wechat.accessToken = JSON.parse(result.content).access_token;
        Meteor.settings.wechat.updatedAt = Date.now();
      }
    }
    return Meteor.settings.wechat.accessToken;
  }
});
