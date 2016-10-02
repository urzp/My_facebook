class UsersController < ApplicationController
  before_action :check_log_in
  before_action :correct_user,   only: [:edit, :update]

  def show
  end

  def edit
    @user = User.find(params[:format])
  end

  def update
    @user = User.find(params[:format])
    if  @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to root_path
    else
      flash[:danger] = 'Invalid old password' if !@user.authenticate(params[:user][:old_password])
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :gender,
        :birthday, :location, :avatar )
  end

  def check_log_in
    unless user_signed_in?
      flash[:danger] = "Please sign in."
      redirect_to root_path
    end
  end

  def correct_user
    @user = User.find(params[:format])

    unless current_user == @user
      flash[:danger] = "Not allowed."
      redirect_to(root_url)
    end
  end

end
