class FacebookSessionsController < ApplicationController

  def show
    connect_status = {}
    connect_status[:signin_status] = !facebook_client.nil?

    respond_to do |format|
      format.json { render :json => connect_status.to_json }
    end
  end

  def create
    respond_to do |format|
      format.html
    end
  end
end
