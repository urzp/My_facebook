class WelcomeController < ApplicationController
  def index
    @index = true #for heade log in form at navigator for any pagese exept index
    @posts = current_user.posts
    @post = Post.new
  end
end
