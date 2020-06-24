class RoomAuthController < ApplicationController 

  def create
    room = Room.find_by(room_name: room_params[:room_name])
    

  end



  private

  def room_params
    params.require(:room).permit(:room_name, :password)
  end



end