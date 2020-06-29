class RoomAuthController < ApplicationController 

  def new
    user = User.new
  end
  
  def create
    room = Room.find_by(room_name: params[:room_name])
    if room && room.authenticate(params[:password])
    
      user = User.create({"username" => params[:username]})
      join = UserRoom.create({"user_id" => user.id, "room_id" => room.id})
      payload = {room_id: room.id}
      token = JWT.encode(payload, "hmac_secret", 'HS256')
      render json: { room: RoomSerializer.new(room), jwt: token, user: user }, status: :accepted
    else
      render json: { error: 'Invalid roomname or password' }, status: :unauthorized
    end

    
  end



  private

  # def room_params
  #   params.require(:room).permit(:room_name, :password)
  # end



end