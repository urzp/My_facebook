class PostsController < ApplicationController


    def create
      @post = current_user.posts.build(post_params)
      @post.date = Time.now
      @post.save
      redirect_to root_path
    end

private

  def post_params
    params.require(:post).permit(:title, :content)
  end

end
