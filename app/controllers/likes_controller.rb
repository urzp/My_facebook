class LikesController < ApplicationController

  def add_delete
    @post = Post.find(params[:format])
    begin
       @post.users_likes << current_user
    rescue
      @post.users_likes.delete(current_user.id)
    end
    redirect_back_or(root_path)
  end

end
