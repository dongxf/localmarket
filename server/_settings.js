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

/*
ServiceConfiguration.configurations.upsert(
  { servcie: "weibo" },
  {
    $set: {
    clientId: "2477162906",
    loginStyle: "popup",
    secret: "b74cbdf3b23d0effa2c3e8620435a42b"
    }
   }
);
*/
