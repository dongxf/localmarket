// Provide defaults for Meteor.settings
//
// To configure your own Twitter keys, see:
//   https://github.com/meteor/meteor/wiki/Configuring-Twitter-in-Local-Market
if (typeof Meteor.settings === 'undefined')
  Meteor.settings = {};

_.defaults(Meteor.settings, {
  twitter: {
    consumerKey: "8P3m74y3i8A97GKhAnErENFnX",
    secret: "WWITqdxeWvN8ngJ3jT9llhVaTxsPdxjLo4Wzq5ffhAXFZnrLLp"
  },
  wechat: {
    appId: 'wxff8cf329bc5ec6be',
    appSecret: 'afe523e9bcd47bdc320a3b336cee95f1',
    accessToken: '',
    updatedAt: 0
  }
});

ServiceConfiguration.configurations.upsert(
  { service: "twitter" },
  {
    $set: {
      //consumerKey: Meteor.settings.twitter.consumerKey,
      //secret: Meteor.settings.twitter.secret
      consumerKey: "8P3m74y3i8A97GKhAnErENFnX",
      secret: "WWITqdxeWvN8ngJ3jT9llhVaTxsPdxjLo4Wzq5ffhAXFZnrLLp"
    }
  }
);

// first, remove configuration entry in case service is already configured
ServiceConfiguration.configurations.remove({
  service: "weibo"
});
ServiceConfiguration.configurations.insert({
  service: "weibo",
  clientId: "158584162",
  secret: "4e3dddf7ce943adcdc837b5ade1d30ae"
  //clientId: "2477162906",
  //secret: "b74cbdf3b23d0effa2c3e8620435a42b"
});


ServiceConfiguration.configurations.remove({
  service: "wechat"
});
ServiceConfiguration.configurations.insert({
  service: "wechat",
  appId: "wx11b10e757aebde2f",
  scope:'basic',
  secret: "ef0fde3e58be478dc26020d12a957b38"
});
