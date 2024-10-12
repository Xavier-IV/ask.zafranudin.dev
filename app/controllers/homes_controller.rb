require "net/http"

class HomesController < ApplicationController
  def index
    @question = Question.new
  end

  def create
    if verify_turnstile(params["cf-turnstile-response"])
      @question = Question.new(question_params)
      if @question.save
        redirect_to root_path, notice: "Your question has been submitted."
      else
        render :index, status: :unprocessable_entity, content_type: "text/html"
      end
    else
      redirect_to root_path, alert: "Failed to verify you are human."
    end
  end


  private

  def verify_turnstile(token)
    uri = URI("https://challenges.cloudflare.com/turnstile/v0/siteverify")
    response = Net::HTTP.post_form(uri, {
      "secret" => Rails.application.credentials[:turnstile_secret_key],
      "response" => token
    })

    json_response = JSON.parse(response.body)
    json_response["success"]
  end

  def question_params
    params.require(:question).permit(:content)
  end
end
