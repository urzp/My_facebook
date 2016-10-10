class PostsController < ApplicationController

    def show
      friends = current_user.frends
      friends = friends << current_user
      sql = ""
      friends.each do |user|
        sql = sql + "user_id = #{user.id} OR "
      end
      @posts = Post.where(sql[0..-5])
      
    end

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

    def edit
      if current_user.posts.find_by(id: params[:format])
        @post = current_user.posts.find_by(id: params[:format])
      else
        flash[:danger] = "You can't edit this post"
        redirect_to  root_url
      end
    end

    def update
      id = params[:post][:id].to_s
      if current_user.posts.find_by(id: id).update_attributes(post_params)
          flash[:success] = "Post updated"
          redirect_to  root_url
      else
        flash[:danger] = "You can't edit this post"
        redirect_to  root_url
      end
    end

private

  def post_params
    params.require(:post).permit(:id, :title, :content)
  end

end
