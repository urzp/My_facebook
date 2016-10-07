class RelationshipsController < ApplicationController
  before_action :check_log_in

  def	create
      @user	=	User.find(params[:wish_id])
      if params[:accept]
        current_user.accept_inv(@user)
      else
        current_user.wish_frends << @user
      end
      current_user.save
      redirect_to	show_users_path(@user)
  end

  def	destroy
      @user	=	User.find(params[:wish_id])
      current_user.delete_realtionship(@user)
      current_user.save
      redirect_to	show_users_path(@user)
  end

end
