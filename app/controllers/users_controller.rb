class UsersController < ApplicationController 


  def index
    users = User.all
    render json: users
  end

  def test
    # users being broadcasted out
    users = User.all 
    room = Room.find(user_params[:room])
    UsersChannel.broadcast_to room, users
  end

  def create
    user = User.new(user_params)
  end

  def show 
    user = User.find(user_params[:id])
  end

  
  def select
    p "=========================="
    p params
    byebug
    updateUser = User.find_by(username: user_params[:currentPlayer])
    updateUser.update(is_active: false)
    room = Room.find(user_params[:room])
    userArray = room.users.select { |roomObj| roomObj.is_active === true }
    currentPlayer = userArray.sample(1).first
    p currentPlayer
    UsersChannel.broadcast_to room, currentPlayer
  end

  def start
    room = Room.find(user_params[:room])
    userArray = room.users.select { |roomObj| roomObj.is_active === true }
    currentPlayer = userArray.sample(1).first
    p currentPlayer
    UsersChannel.broadcast_to room, currentPlayer
  end


  private

  def user_params
    params.require(:user).permit(:username, :id, :room, :currentPlayer)
  end

end



    # if user.save
    #   serialized_data = ActiveModelSerializers::Adapter::Json.new(
    #     UserSerializer.new(user)
    #   ).serializable_hash
    #   UsersChannel.broadcast_to room, serialized_data
    #   head :ok
    # end

    # userArray = room.users.select do |roomObj|
    #   byebug
    #   if roomObj.is_active === true
    #     return roomObj
    #   end
    # end