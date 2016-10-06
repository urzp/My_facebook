class ApplicationController < ActionController::Base
before_action :configure_permitted_parameters, if: :devise_controller?
before_action :check_new_event

  protect_from_forgery with: :exception



protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name])
  end

  def check_new_event
    #cookies[events_user_id] = [frends, invites]
    if user_signed_in?
      events_user_id = ":event_user_#{current_user.id}"
      frends = current_user.frends.count
      invites = current_user.current_inventes.count
      if cookies[events_user_id]
        cookies_frends = cookies[events_user_id][0]
        cookies_invites = cookies[events_user_id][2]
        if cookies_frends != frends.to_s || cookies_invites != invites.to_s
          flash[:success] = "you have a new event"
          cookies[events_user_id] = [frends, invites]
          return {frends: frends, invites: invites}
        else
          return false
        end
      else
        cookies[events_user_id] = [frends, invites]
      end
    end

  end

end
