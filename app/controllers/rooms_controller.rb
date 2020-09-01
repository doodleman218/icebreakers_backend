require "jwt"

class RoomsController < ApplicationController 

  def new
    room = Room.new
    user = User.new
  end
  
  def create
    user = User.create({"username" => room_params[:username], :is_active => true})
    room = create_room(user)
    
    if room
      payload = {room_id: room.id}
      token = JWT.encode(payload, "hmac_secret", 'HS256') 
      render json: { room: room, jwt: token, user: user }, status: :created
    else
      render json: { errors: user.errors.messages }, status: :not_acceptable
    end
  end

  def destroy
    room = Room.find(room_params[:id])
    room.destroy

    render json: room
  end

  private

  def room_params
    params
      .require(:room)
      .permit(:room_name, :password, :username, :is_active, :id)
  end

  def create_room(user)
    room = Room.create({
      "room_name" => room_params[:room_name],
      "password" => room_params[:password],
      "host_id" => user.id,
      "host_name" => user.username
    })
    
    UserRoom.create({"user_id" => user.id, "room_id" => room.id})
    
    Question.all.map do |question|
      RoomQuestion.create({
        room_id: room.id,
        question_id: question.id,
        is_active: true
      })
    end

    room
  end
end