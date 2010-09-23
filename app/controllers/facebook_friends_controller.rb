class FacebookFriendsController < ApplicationController
  def index
    @friends = facebook_client.me.friends

    respond_to do |format|
      format.html
    end
  end
end
