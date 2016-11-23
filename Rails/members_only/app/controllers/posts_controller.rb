class PostsController < ApplicationController
  before_filter :logged_in?, :only => [:new, :create]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(   title: params[:post][:title],
                        body: params[:post][:body],
                        user_id: current_user.id)
    if @post.save
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def index
    @posts = Post.all
  end
end
