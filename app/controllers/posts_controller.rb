class PostsController < ApplicationController
  before_action :authenticate_user!, only: :create

  def index
    respond_with Post.all
  end

  def create
    respond_with Post.create(post_params.merge(user_id: current_user.id))
  end

  def show
    respond_with Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:body, :title, :price)
  end
end
