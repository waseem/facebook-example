var fb = {
  signinFbUser: function () {
    $.get('/facebook_session', null, function (connect_status) {
      if (connect_status.signin_status) {
        fb.submitConnectForm();
      } else {
        alert("Please connect again.");
      }
    }, 'json');
  },

  submitConnectForm: function () {
    $('#connect_to_facebook_form').submit();
  }
}
