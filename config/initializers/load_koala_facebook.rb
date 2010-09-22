# load facebook information for this environment
#
# 1. Put this file in config/initializers/load_koala_facebook.rb
#
# 2. Create config/facebook.yml as following
#
# development:
#   api_key: <API_KEY>
#   secret_key: <SECRET_KEY>
#   app_id: <APP_ID>
#
# production:
#   api_key: <API_KEY>
#   secret_key: <SECRET_KEY>
#   app_id: <APP_ID>
#
# 3. Change your application controller as following
#
# helper_method :facebook_client
# before_filter :set_facebook_client
#
# def set_facebook_client
#   oauth = Koala::Facebook::OAuth.new("#{request.scheme}://#{request.host}/")
#   @facebook_client ||= if facebook_cookies = oauth.get_user_info_from_cookie(cookies)
                           #Koala::Facebook::GraphAndRestAPI.new(facebook_cookies['access_token'])
#                        end
# end
# 
# def facebook_client
#   @facebook_client
# end

# Monkey-patch in Facebook config so Koala knows to 
# # automatically use Facebook settings from here if none are given
#
module Facebook
  CONFIG = YAML.load(ERB.new(File.read("#{RAILS_ROOT}/config/facebook.yml")).result)[RAILS_ENV]
  APP_ID = CONFIG['app_id']
  SECRET = CONFIG['secret_key']
end

Koala::Facebook::OAuth.class_eval do
  def initialize_with_default_settings(*args)
    case args.size
    when 0, 1
      raise "application id and/or secret are not specified in the config" unless Facebook::APP_ID && Facebook::SECRET
      initialize_without_default_settings(Facebook::APP_ID.to_s, Facebook::SECRET.to_s, args.first)
    when 2, 3
      initialize_without_default_settings(*args) 
    end
  end 

  alias_method_chain :initialize, :default_settings 
end
