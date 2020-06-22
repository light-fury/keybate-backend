require 'aws-sdk'

class SignController < ApplicationController
  def sign
    expires = 10.hours.from_now
    resource = Aws::S3::Resource.new
    obj = resource.bucket(ENV['AWS_S3_BUCKET'])
      .object("pp/#{DateTime.now}-#{params[:name]}")
      .presigned_post(acl: 'public-read', expires: expires)
    json = obj.fields
    # If you would like to send the endpoint back
    json['endpoint'] = obj.url
    render json: json
  end
end
