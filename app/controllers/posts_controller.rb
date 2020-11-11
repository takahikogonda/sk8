class PostsController < ApplicationController
	before_action :correct_user, only: [:edit, :update]
	before_action :authenticate_user!

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)
		@posts = Post.all
    	@post.user_id = current_user.id
    	if @post.save
    		flash[:notice] = "successfully"
    		redirect_to post_path(@post)
    	else
    		@user = current_user
    		#flash[:notice] = "error"
    		render "index"
    	end
	end

	def index
		@posts = Post.all
		@post = Post.new
		@user = current_user
	end

	def show
		@post = Post.find(params[:id])
		@user = current_user
		@postbook = Post.new
		@post_comments = @post.comments
		@post_comments = @Comment.new
	end

	def update
		@post = Post.find(params[:id])
		if @post.update(book_params)
			flash[:notice] = "successfully"
			redirect_to post_path(@post)
		else
			flash[:notice] = "error"
			render "edit"
		end
	end
	def edit
		@post = Post.find(params[:id])
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to posts_path
	end

	private

	def correct_user
		@post = Post.find(params[:id])
		if @post.user != current_user
			redirect_to posts_path
		end
	end

	def post_params
		params.require(:post.permit(:body)
	end

end
