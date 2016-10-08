class PostsController < ApplicationController


    def create
      @post = current_user.posts.build(post_params)
      @post.date = Time.now
      @post.save
      redirect_to root_path
    end

    def destroy

      if current_user.posts.find_by(id: params[:format])
        current_user.posts.find_by(id: params[:format]).destroy
        flash[:success] = "Micropost deleted"
        redirect_to  root_url
      else
        flash[:danger] = "You can't delete this post"
        redirect_to  root_url
      end
    end

private

  def post_params
    params.require(:post).permit(:title, :content)
  end

end
