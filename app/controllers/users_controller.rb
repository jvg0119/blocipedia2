class UsersController < ApplicationController
	before_action :authenticate_user! 
	before_action :set_user

  def show
  end

  def edit
  end

  def update
  	if @user.update_attributes(user_params)
  		flash[:notice] = "Your user name was updated successfully!"
  		redirect_to :back 
  	else
  		flash[:error] = "There was an error updating your user name. Please try again."
  		render :edit
  	end
  end

  private 
  def user_params
  	params.require(:user).permit(:name)
  end

  def set_user
  	@user = User.find(params[:id])
  end

end
