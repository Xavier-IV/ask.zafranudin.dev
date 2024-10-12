class AnonSessionsController < ApplicationController
  def new
    if session[:anon_token_id].present? && AnonToken.find_by(id: session[:anon_token_id])&.valid_token?
      redirect_to questions_path, notice: "You are already logged in."
    end
  end

  def create
    token = params[:token]

    if token.blank?
      flash.now[:alert] = "Token can't be blank."
      render :new, status: :unprocessable_entity
      return
    end

    anon_token = AnonToken.find_by(token: token)

    if anon_token&.valid_token?
      session[:anon_token_id] = anon_token.id
      redirect_to questions_path, notice: "Successfully authenticated."
    else
      flash.now[:alert] = "Invalid or expired token."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:anon_token_id)
    redirect_to root_path, notice: "Logged out."
  end
end
