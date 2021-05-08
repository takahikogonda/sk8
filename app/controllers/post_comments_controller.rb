class PostCommentsController < ApplicationController

	def create
		@post = Post.find_by(id: params[:post_id])
		@post_comment = PostComment.new(post: @post)
		@post_comment.attributes = post_comment_params
		if @post_comment.save
			redirect_to post_path(id: @post.id)
		else
			redirect_back(fallback_location: root_path)
		end
	end

	def destroy
		PostComment.find(params[:id]).destroy
    redirect_to post_path(params[:post_id])
	end

	private

	def post_comment_params
		params.require(:post_comment).permit(:comment, images: []).merge(user_id: current_user.id)
	end

end
