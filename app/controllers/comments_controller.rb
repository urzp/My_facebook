class CommentsController < ApplicationController
  def create
    @post = Post.find_by(id: params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.post = @post
    @comment.user = current_user
    @comment.save
    redirect_back_or(root_path)
  end
private

  def  comment_params
    params.require(:comment).permit(:content)
  end

end
