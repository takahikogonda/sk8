class PostCommentsController < ApplicationController

	def create
		@post_comment = Comment.new(comment_params)
		@post_comment.user_id = current_uer.user_id
		if @post_comment.save
			redirect_back(fallback_location: root_path)
		else
			redirect_back(fallback_location: root_path)
	end

	def destroy
	end

	private

	def post_coment_params
		params.require(:comment).permit(content)
	end

end
