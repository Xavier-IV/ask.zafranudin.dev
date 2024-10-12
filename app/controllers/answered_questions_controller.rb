class AnsweredQuestionsController < ApplicationController
  def index
    @questions = Question.where(answered: true)
  end

  def show
  end
end
