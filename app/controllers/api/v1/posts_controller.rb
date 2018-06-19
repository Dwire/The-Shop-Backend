class Api::V1::PostsController < ApplicationController
  before_action :set_post, only: [:show]

  def index
    posts = Post.all
    render json: posts, status: 200
  end

  def create
    post = Post.create(post_params)
    if (post && logged_in?)
      render json: post, status: 201
    else
      render json: {error: 'No user could be created'}, status: 401
    end
  end

  def show
    render json: @post, status: 200
  end

  # def update
  # end
  # def delete
  # end

  private
  def post_params
    params.permit(:title, :body, :topic, :user_id)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
