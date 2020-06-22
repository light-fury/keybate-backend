class ApplicationController < ActionController::API
  helper UserHelper
  helper PollHelper
  
  include Pundit

  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :configure_permitted_parameters, if: :devise_controller?
  serialization_scope :view_context

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_from_record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :rescue_from_unprocessable_entity

  def rescue_from_unprocessable_entity(exception)
    @errors = exception.record.errors
    render json: { errors: exception.record.errors }, status: :unprocessable_entity
  end

  def rescue_from_record_not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end

  # Always render the show.json.jbuilder after creating, updating or deleting a record
  def render(*args)
    possible_actions = %w(
      create update destroy join mark_as_read block unblock
      publish pin send_to_bottom call open display_results
    )
    args = ['show'] if args.empty? && possible_actions.include?(action_name)
    super
  end

  def pundit_user
    current_api_v1_user
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end
end
