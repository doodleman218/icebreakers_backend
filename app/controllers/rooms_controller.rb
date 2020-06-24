class RoomsController < ApplicationController 

    def new
      room = Room.create(params[:room_name, :password])
    end
  
    def create
      room = Room.create(params[:room_name, :password])

    end



end