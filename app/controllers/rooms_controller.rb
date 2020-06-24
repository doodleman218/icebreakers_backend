class RoomsController < ApplicationController 

  def new
    room = Room.create(params[:room_name, :password])
  end
  
  def create
    room = Room.create(params[:room_name, :password])
  end


  private

  def room_params
    params.require(:room).permit(:room_name, :password)
  end




end