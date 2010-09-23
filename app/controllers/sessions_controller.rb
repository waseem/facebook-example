class SessionsController < ApplicationController

  def new
    respond_to do |format|
      format.html
    end
  end

  def show
    connect_status = {}
    connect_status[:signin_status] = !facebook_client.nil?

    respond_to do |format|
      format.json { render :json => connect_status.to_json }
    end
  end

  def create
    @me = facebook_client.me.info([:name, :pic_big])
    logger.info @me.inspect
    respond_to do |format|
      format.html
    end
  end

  def destroy
    respond_to do |format|
      format.html { redirect_to '/' }
    end
  end
end
