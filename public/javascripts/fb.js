var fb = {
  signinFbUser: function () {
    $.get('/session', null, function (connect_status) {
      if (connect_status.signin_status) {
        fb.submitConnectForm();
      } else {
        alert("Please connect again.");
      }
    }, 'json');
  },

  submitConnectForm: function () {
    $('#connect_to_facebook_form').submit();
  },

  signoutFbUser: function () {
    $('#signout').click(function () {
      FB.logout(function (response) {});
    });
  },

  preloadActions: function () {
    fb.signoutFbUser();
  }
}

$(document).ready(function () {
  fb.preloadActions();
});
