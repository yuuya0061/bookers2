class UsersController < ApplicationController
  allow_unauthenticated_access only: [ :new, :create ] 
  before_action :correct_user, only: [ :edit, :update ]
 
  def index
    @users = User.all
    @user = Current.user
    @new_book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @new_book = Book.new
    @books = @user.books
  end

  def new
    @user = User.new
  end
 
  def create
    @user = User.new(user_params)
    if @user.save
      # ユーザー登録成功後、ログイン画面へリダイレクト
      start_new_session_for @user
      redirect_to @user, notice: "Welcome! You have signed up successfully."
    else
      # エラー時はフォームを再表示
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
     @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: "You have updated user successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end
 
  private
 
  def user_params
    # name, email_address, password, password_confirmation を許可
    params.require(:user).permit(:name, :email_address, :password, :password_confirmation, :profile_image, :introduction)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to Current.user if @user != Current.user
  end
end
