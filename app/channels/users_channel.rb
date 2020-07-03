class UsersChannel < ApplicationCable::Channel
  def subscribed
    room = Room.find(params[:room])
    # not sure about these params
    stream_for room
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
