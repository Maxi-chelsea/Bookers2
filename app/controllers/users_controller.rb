class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = user.find(params[:id])
    if @user.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to books_path
    else
      render("users/edit")
    end
  end
end
