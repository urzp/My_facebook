class WelcomeController < ApplicationController
  def index
    @index = true #for heade log in form at navigator for any pagese exept index
    @posts = current_user.posts if user_signed_in?
    @post = Post.new if user_signed_in?
  end
end
