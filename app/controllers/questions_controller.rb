class QuestionsController < ApplicationController
  before_action :authenticate_anon!

  def index
    @questions = Question.all
  end

  def show
    @question = Question.find_by(public_id: params[:id])

    if @question
        render :show
    else
        redirect_to questions_path, alert: "Question not found."
    end
  end

  private

  def authenticate_anon!
    unless session[:anon_token_id] && AnonToken.find_by(id: session[:anon_token_id])&.valid_token?
      redirect_to new_anon_session_path, alert: "You must be logged in with a valid token to access this page."
    end
  end
end
