class BooksController < ApplicationController
  before_action :move_to_signed_in
  before_action :ensure_correct_user, only: [:edit, :update]


  def index
    @book = Book.new
    @user = current_user
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      @user = current_user
      @books = Book.all
      render :index
    end
  end

  def show
    @book = Book.new
    @books = Book.find(params[:id])
    @user = @books.user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    book = current_user.books.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private
    def book_params
      params.require(:book).permit(:title, :body)
    end

    def move_to_signed_in
      unless user_signed_in?
        redirect_to "/users/sign_in"
      end
    end

    def ensure_correct_user
      book = Book.find(params[:id])
      unless book.user_id == current_user.id
        redirect_to books_path
      end
    end
end
