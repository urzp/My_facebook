class ApplicationController < ActionController::Base
before_action :configure_permitted_parameters, if: :devise_controller?
before_action :check_friends,  if: :user_signed_in?

  protect_from_forgery with: :exception



protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name])
  end

  def check_friends
    @frends = current_user.frends.count
    @new_frends = current_user.new_friends.count
    @invites = current_user.current_invites.count
    @wish_frends = current_user.current_wishes.count
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
