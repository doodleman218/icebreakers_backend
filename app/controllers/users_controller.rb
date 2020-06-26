class UsersController < ApplicationController 


  def index
    users = User.all
    render json: users
  end

  def create
    user = User.new(user_params)
    

  end



  def show 
    user = User.find(user_params[:id])
  end


  private

  def user_params
    params.require(:username).permit(:username, :id)
  end

end



    # if user.save
    #   serialized_data = ActiveModelSerializers::Adapter::Json.new(
    #     UserSerializer.new(user)
    #   ).serializable_hash
    #   UsersChannel.broadcast_to room, serialized_data
    #   head :ok
    # end