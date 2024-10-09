class UsersController < ApplicationController
  before_action :authenticate_user!  # ユーザーがログインしているか確認
  before_action :set_user

  def show_account
  end

  def show_profile
  end

  def edit_profile
  end

  def update_profile
    if @user.update(user_params)
      redirect_to users_show_profile_path
    else
      render "edit_profile"
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:avatar, :name, :introduction)
  end
end
