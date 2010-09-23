class FacebookAlbumsController < ApplicationController
  def index
    @albums = facebook_client.me.albums

    respond_to do |format|
      format.html
    end
  end

  def show
    @photos = Joey::Album.find(params[:id], facebook_client).photos

    logger.info @photos.inspect
    respond_to do |format|
      format.html
    end
  end
end
