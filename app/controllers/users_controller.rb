class UsersController < ApplicationController
  def edit
    @user = User.find(params[:id])
  end

  def show
    @book = Book.new
    @user = current_user
    @user = User.find(params[:id])
    @books = @user.books
  end
  
  def index
    @book = Book.new
    @users = User.all
    @user = current_user
  end
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    flash[:notice] = "You have updated user successfully."
    redirect_to user_path(@user) 
  else
    render :edit
  end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
