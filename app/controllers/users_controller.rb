class UsersController < ApplicationController
	before_action :authenticate_user!

  def show
  	@user = User.find(params[:id])
    @post = Post.new
  end

  def index
    @post = Post.new
    @users = User.all
    @user = current_user
  end


  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user.id)
    end
  end

  def update
  	@user = User.find(params[:id])
    if @user.update(user_params)
        flash[:success] = "successfully"
        redirect_to user_path(@user.id)
      else
        #@user = current_user
        flash[:notice] = "error"
        render "edit"
      end
  end

  def search
    @user_or_post = params[:option]
    if @user_or_post == "1"
      @users = User.search(params[:search], @user_or_post)
    else
      @posts = Post.search(params[:search], @user_or_post)
    end
  end


  private



  def user_params
    params.require(:user).permit(:name, :image, :introduction, images: [])
  end

end
