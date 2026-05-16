class UsersController < ApplicationController
 allow_unauthenticated_access only: [:new, :create] 
 
  def new
    @user = User.new
  end
 
  def create
    @user = User.new(user_params)
    if @user.save
      # ユーザー登録成功後、ログイン画面へリダイレクト
      start_new_session_for @user
      redirect_to after_authentication_url, notice: "ようこそ！登録が完了しました。"
    else
      # エラー時はフォームを再表示
      render :new, status: :unprocessable_entity
    end
  end
 
  private
 
  def user_params
    # name, email_address, password, password_confirmation を許可
    params.require(:user).permit(:name, :email_address, :password, :password_confirmation)
  end

end
