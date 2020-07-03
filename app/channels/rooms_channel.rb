class RoomsChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "rooms_channel"
    # # does this need to be more specific
    # # dont need this?
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
