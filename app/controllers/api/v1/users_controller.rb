class Api::V1::UsersController < ApplicationController
  # before_action :set_user, only: [:show]

  def index
    users = User.all
    if logged_in?
      render json: users, status: 200
    else
      render json: {error: 'No user could be found'}, status: 401
    end
  end


  # def create
  #   @user = User.create(user_params)
  #   if @user
  #     render json: @user, status: 201
  #   else
  #     render json: {message: "Couldn't update your hob's job"}, status: 401
  #   end
  # end

  def update
    # @user = User.find(params[:id])
    if logged_in?
      if @user.update(user_params)
        render json: @user, status: 200
      else
        render json: {message: "Couldn't update your profile"}, status: 401
      end
    end
  end

  # def show
  #   render json: @user, status: 200
  # end

  # def update
  # end

  private
  def user_params
    params.permit(:id, :name, :email, :project, :guru, :password, :latitude, :longitude,)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
