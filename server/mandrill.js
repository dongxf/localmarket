// in server code
Meteor.startup(function() {
  return Meteor.Mandrill.config({
    username: "dongxf@gmail.com",
         key: "2327c3f5-f135-4c5e-9272-e0c30a71812e"
  })
});
this.sendEmail = function(to, subject, htmlText) {
  return Meteor.Mandrill.send({
    to: to,
    from: 'trust@fooways.com',
    subject: subject,
    html: htmlText
  });
};
