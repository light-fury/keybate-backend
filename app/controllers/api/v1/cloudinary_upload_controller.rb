class Api::V1::CloudinaryUploadController < ApplicationController
  before_action :authenticate_api_v1_user!
  respond_to :json
  def upload
    if params[:image]
      uploaded_file = params[:image]
      cloudinary_file = Cloudinary::Uploader.upload(uploaded_file)
      render json: cloudinary_file
    else
      head :no_content
    end
  end
end
