class PostsController < ApplicationController
  before_action :authenticate_user!, only: :create
  load_and_authorize_resource

  def index
    respond_with Post.where(status: 'approved')
  end

  def create
    post = Post.create(post_params.merge(user_id: current_user.id))
    post.categories << Category.where(id: params[:categories].map { |e| e[:id] })
    respond_with post
  end

  def show
    respond_with Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:body, :title, :price)
  end
end
