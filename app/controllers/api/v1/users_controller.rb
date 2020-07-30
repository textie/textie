class Api::V1::UsersController < ApplicationController
  expose :user

  def create
    if user.save
      render :show, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :full_name, :password)
  end
end
