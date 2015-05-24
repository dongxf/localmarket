Template.logoutOverlay.events({
  'click .js-logout': function() {
    Meteor.logout();
    Overlay.close();
  }
});
