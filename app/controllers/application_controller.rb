# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  #

  helper_method :facebook_client
  before_filter :set_facebook_client

  def set_facebook_client
    oauth = Koala::Facebook::OAuth.new("#{request.scheme}://#{request.host}/")
    logger.info cookies.inspect
    @facebook_client ||= if facebook_cookies = oauth.get_user_info_from_cookie(cookies)
                           Koala::Facebook::GraphAndRestAPI.new(facebook_cookies['access_token'])
                         end
  end

  def facebook_client
    @facebook_client
  end
end
