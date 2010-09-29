module FacebookHelpers
  def setup_fb_connect_cookies(user)
    cookies['fbs_' + Facebook::APP_ID.to_s] = Facebook::CONFIG[user]
  end

  def fail_facebook
    flunk('Fffffuuuuuu: Perhaps you need to connect with facebook again and put a new cookie hash in config/facebook.yml or check if your tunnel is running.')
  end

  def clear_fb_cookies
    cookies.delete('fbs_' + Facebook::APP_ID.to_s)
  end
end

World(FacebookHelpers)
