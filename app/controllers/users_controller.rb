class UsersController < ApplicationController
  def show
    @user = User.find_by id: params[:id]
    return if user
    flash[:success] = t "users.flash.failed_show"
    redirect_to new_user_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if user.save
      log_in user
      flash[:success] = t "users.flash.success_create"
      redirect_to user
    else
      render :new
    end
  end

  private

  attr_reader :user

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end
end
