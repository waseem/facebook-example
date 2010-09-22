var fb = {
  signinFbUser: function () {
    $.get('/facebook_user', null, function (user) {
    }, 'json');
  }
}
