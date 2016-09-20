class CategoriesController < ApplicationController
  def index
    respond_with Category.all
  end

  def show
    respond_with Category.find(params[:id]).posts.where(status: 'approved')
  end
end
