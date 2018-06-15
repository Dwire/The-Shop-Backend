class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def index
    users = User.all
    if logged_in?
      render json: users, status: 200
    else
      render json: {error: 'No user could be found'}, status: 401
    end
  end


  def create
    @user = User.create(user_params)
    if @user
      render json: @user, status: 201
    else
      render json: {message: "Couldn't update your hob's job"}, status: 401
    end
  end

  # def update
  #   @hobbit = Hobbit.find(params[:id])
  #   if @hobbit.update(hobbit_params)
  #     render json: @hobbit, status: 200
  #   else
  #     render json: {message: "Couldn't update your hob's job"}, status: 401
  #   end
  # end

  def show
    render json: @user, status: 200
  end

  # def update
  # end

  private
  def user_params
    params.permit(:name, :email, :project, :guru, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
