class UsersController < ApplicationController 


  def create
    user = User.create(user_params)

  end

  def index
    users = User.all
  end

  def show 
    user = User.find(user_params[:id])
  end


  private

  def user_params
    params.require(:username).permit(:username, :id)
  end

end