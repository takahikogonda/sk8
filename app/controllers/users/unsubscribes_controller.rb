class Users::UnsubscribesController < ApplicationController


 def destroy
    @user = User.find_by(id: params[:user_id])
    @user.destroy
    reset_session
    redirect_to root_path
  end

  def edit
    @user = User.find_by(id: params[:user_id])
  end

end
