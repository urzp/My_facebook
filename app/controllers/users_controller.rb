class UsersController < ApplicationController
  before_action :check_log_in
  before_action :correct_user,   only: [:edit, :update]

  def index
    @users = User.all
  end




  def show_new_friends
    @users = current_user.new_friends
    @users.map{|user| current_user.seen_friend(user) }
    render 'index'
  end

  def show_friends
    @users = current_user.frends
    render 'index'
  end

  def show_invites
    @users = current_user.current_invites
    render 'index'
  end

  def show_wishes
    @users = current_user.current_wishes
    render 'index'
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
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


end
