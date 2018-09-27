class PostsController < ApplicationController
  before_action :find_post, only: [:update, :edit, :show, :destroy]

  def new
    return redirect_to root_path unless user_signed_in?
    @post = Post.new
  end

  def create
    @post = current_user.posts.create(post_params)
    redirect_to @post
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def edit
  end

  def index
    @posts = Post.order(created_at: :desc)
  end

  def show
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

  def find_post
    @post = Post.find(params[:id])
  end

end
