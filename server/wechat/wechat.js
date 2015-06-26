getWechatTicket=function(){
  if ((Date.now()-Meteor.settings.wechat.updatedAt) > 7100000) {
      var appid = Meteor.settings.wechat.appId;
      //Meteor.settings.wechat.appId;
      var secret = Meteor.settings.wechat.appSecret;
      var url = 'https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=' + appid + '&secret=' + secret;
      var result = Meteor.http.get(url, {timeout: 3000});
      var token;
      var ticket;
      if (result.statusCode == 200) {
        token = JSON.parse(result.content).access_token;
        Meteor.settings.wechat.accessToken = token;
        var url = 'https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=' +token + '&type=jsapi' ;
        var result = Meteor.http.get(url, {timeout: 3000});
        if (result.statusCode == 200) {
          ticket = JSON.parse(result.content).ticket;
          Meteor.settings.wechat.jsapiTicket = ticket;
          Meteor.settings.wechat.updatedAt = Date.now();
        }
      }
  }
  return Meteor.settings.wechat.jsapiTicket;
};

createNonceStr = function() {
  return Math.random().toString(36).substr(2,15);
};

createTimeStamp = function() {
  return parseInt(new Date().getTime()/1000)+'';
};

calcSignature = function(ticket, noncestr, ts, url){
  var str = 'jsapi_ticket=' + ticket + '&noncestr=' + noncestr + '&timestamp='+ ts +'&url=' + url;
  var jsSHA = Npm.require('jssha');
  shaObj = new jsSHA(str, 'TEXT');
  return shaObj.getHash('SHA-1', 'HEX');
}

Meteor.methods({
  'getWechatSignature': function(url) {
    var tk=getWechatTicket();
    var ns=createNonceStr();
    var ts=createTimeStamp();
    var sig=calcSignature(tk,ns,ts,url);
    return {signature: sig, noncestr: ns, timestampe: ts, appid: Meteor.settings.wechat.appId}
  }
});
