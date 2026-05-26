class BooksController < ApplicationController
  before_action :correct_user, only: [ :edit, :update, :destroy ]

  def index
    @books = Book.all
    @new_book = Book.new
    @user = Current.user
  end

  def show
    @new_book = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end
 
  def create
    @new_book = Current.user.books.new(book_params)
    if @new_book.save
      redirect_to @new_book, notice: "You have created book successfully."
    else
      @user = @new_book.user
      @books = Book.all
      @new_book.title = nil
      render "books/index", status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: "You have updated book successfully."
    else
      @book.title = nil
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path
  end
 
  private
 
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def correct_user
    @book = Current.user.books.find_by_id(params[:id])
    redirect_to books_path if !@book
  end
end
