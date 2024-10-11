class AnonSessionsController < ApplicationController
  def new
  end

  def create
    token = params[:token]
    anon_token = AnonToken.find_by(token: token)

    if anon_token&.valid_token?
      session[:anon_token_id] = anon_token.id
      redirect_to questions_path, notice: "Successfully authenticated."
    else
      flash.now[:alert] = "Invalid or expired token."
      render :new
    end
  end

  def destroy
    session.delete(:anon_token_id)
    redirect_to root_path, notice: "Logged out."
  end
end
