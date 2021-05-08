class SearchesController < ApplicationController

def index
	@posts = Post.where('body like ?',"%#{params[:search]}%")
	@users = User.where('name like ?',"%#{params[:search]}%")
end





end
