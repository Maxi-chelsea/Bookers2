class UsersController < ApplicationController
  def index
    @books = Book.all
    @book = Book.new
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
end
