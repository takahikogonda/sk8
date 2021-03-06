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
    	if @post.valid?
    		@post.save
    		flash[:notice] = "successfully"
    		redirect_to post_path(@post)
    	else
    		@user = current_user
    		@tag_list = Tag.all
    		render "index"
    	end
	end

	def index
		@posts = Post.all
		@post = Post.new
		@user = current_user
		@tag_list = Tag.all
	end

	def show
		@post = Post.find(params[:id])
		@user = current_user
		@newpost = Post.new
		@post_comment = PostComment.new(post: @post)
		@post_tags = @post.tags
	end

	def update
		@post = Post.find(params[:id])
		if @post.update(post_params)
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

	# def search
		# @post = Post.search(params[:search])
	# end

	def search
		@tag_list = Tag.all
		@tag = Tag.find(params[:tag_id])
		@posts = @tag.posts.all
	end

	private

	def correct_user
		@post = Post.find(params[:id])
		if @post.user != current_user
			redirect_to posts_path
		end
	end

	def post_params
		params.require(:post).permit(:body, images: [])
	end

end
