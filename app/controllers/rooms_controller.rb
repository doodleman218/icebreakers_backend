require "jwt"

class RoomsController < ApplicationController 

  def new
    room = Room.new
    user = User.new
  end
  
  def create
    user = User.create({"username" => params[:username]})
    room = Room.create({"room_name" => room_params[:room_name], "password" => room_params[:password], "host_id" => user.id})
    join = UserRoom.create({"user_id" => user.id, "room_id" => room.id})
    if room.valid?
      payload = {room_id: room.id}
      token = JWT.encode(payload, "hmac_secret", 'HS256') 
      render json: { room: room, jwt: token }, status: :created
      
    else
      render json: { errors: user.errors.messages }, status: :not_acceptable
    end
  end

  
  def destroy
    # p params "++++++++++++"
    # destroy user
    room = Room.find(params[:id])
    render json: "success"
    room.destroy
  end


  private

  def room_params
    params.require(:room).permit(:room_name, :password)
  end

  # def user_params
  #   params.require(:user).permit(:username)
  # end




end