class RoomAuthController < ApplicationController 

  def new
    user = User.new
  end
  
  def create
    room = Room.find_by(room_name: room_params[:room_name])
    
    user = User.create({"username" => params[:username]})
  end



  private

  def room_params
    params.require(:room).permit(:room_name, :password)
  end



end