class Api::V1::FavoriteQuestionsController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_filter :set_favorite_question, only: [:show, :update, :destroy]
  respond_to :json

  def index
    if params[:question_id] && params[:user_id]
      @favorite_questions  = FavoriteQuestion.where(question_id: params[:question_id], user_id: params[:user_id])
    elsif params[:question_id]
      @favorite_questions  = FavoriteQuestion.where(question_id: params[:question_id])
    elsif params[:user_id]
      @favorite_questions  = FavoriteQuestion.where(user_id: params[:user_id])
    elsif params[:id]
      @favorite_questions = FavoriteQuestion.where(id: params[:id])
    end

    render json: @favorite_questions
  end

  def show
    render json: @favorite_question, serializer: FavoriteQuestionSerializer
  end

  def create
    @favorite_question = FavoriteQuestion.new(favorite_question_params)

    if @favorite_question.save
      render json: @favorite_question, status: :created, location: [:api, @favorite_question]
    else
      render json: { errors: @favorite_question.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @favorite_question.update(favorite_question_params)

      head :no_content
    else
      render json: { errors: @favorite_question.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @favorite_question.destroy
    head :no_content
  end

  private

    def set_favorite_question
      @favorite_question = FavoriteQuestion.find(params[:id])
    end

    def favorite_question_params
      params.require(:favorite_question).permit(:user_id, :question_id, :room_name)
    end

end
