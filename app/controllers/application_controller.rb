class ApplicationController < ActionController::Base
before_action :configure_permitted_parameters, if: :devise_controller?
before_action :check_invites, :check_friends, :check_new_friends , if: :user_signed_in?

  protect_from_forgery with: :exception



protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name])
  end

  def check_friends
    @frends = current_user.frends.count
  end

  def check_new_friends
    @new_frends = 0
  end

  def check_invites
    @invites = current_user.current_invites.count
  end

  def check_new_event
    #cookies[events_user_id] = [frends, invites]

    if user_signed_in?
      events_user_id = ":event_user_#{current_user.id}"
      frends = current_user.frends.count
      invites = current_user.current_invites.count
      @frends = frends
      @invites = invites

      if cookies[events_user_id]
        cookies_frends = cookies[events_user_id][0]
        cookies_invites = cookies[events_user_id][2]
        cookies_new_frends = cookies[events_user_id][4]
        if cookies_frends.to_i != frends
          cookies[events_user_id] = [frends, invites, frends.to_i - cookies_frends.to_i]
        end

        if cookies_new_frends != "0" || cookies_invites != invites.to_s
          flash[:success] = "you have a new event"
          @events = {frends: frends, invites: invites, new_frends: cookies_new_frends}
          return true
        end
      else
        cookies[events_user_id] = [frends, invites, 0]
      end
    end
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
