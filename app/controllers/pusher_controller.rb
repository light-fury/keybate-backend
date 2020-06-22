class PusherController < ApplicationController
  def auth
    # true will be replaced by current_api_v1_user once users are created
    if true
      response = Pusher[params[:channel_name]].authenticate(params[:socket_id])
      render :json => response, :callback => params[:callback]
    else
      render :text => "Forbidden", :status => '403'
    end
  end

  # def hello_world
  #   test = Pusher.notify(["donuts"], {
  #     apns: {
  #       aps: {
  #         alert: {
  #           body: 'hello world'
  #         }
  #       }
  #     },
  #     webhook_url: 'https://requestb.in/zg38o3zg',
  #     webhook_level: 'DEBUG'
  #   })
  #   p test
  #   render :text => "notify"
  # end
end
