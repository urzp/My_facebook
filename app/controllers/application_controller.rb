class ApplicationController < ActionController::Base
before_action :configure_permitted_parameters, if: :devise_controller?
before_action :check_new_event

  protect_from_forgery with: :exception



protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name])
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

  def  check_new_event
    if user_signed_in?
      profile = ":#{current_user.id}_user"
      puts "------------------------------#{cookies[profile]}"
      if cookies[:us]
        old_events = cookies[user]
        if old_events[:frends] != current_user.frends.count or
                            old_events[:invites] != current_user.current_invites.count
          dif_frends = current_user.frends.count - old_events[:frends]
          dif_invites = current_user.current_invites.count  - old_events[:invites]
          flash[:success] = "You have new event new friends #{dif_frends} new invites #{dif_invites} "
          return new_events = {frends: dif_frends, invites: dif_invites}
        end
      else
          puts "+++++++++++ #{profile}"
        events =   {frends: current_user.frends.count, invites: current_user.current_invites.count}
        cookies["#{profile}_frends"] = current_user.frends.count
        puts "+++++++++++ #{cookies["#{profile}_frends"]} "
      end
    end
    return false
  end

end
