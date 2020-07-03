class RoomSerializer < ActiveModel::Serializer
  attributes :id, :room_name, :host_id

  has_many :users
  # not sure if this is needed

  def user
    { username: self.object.user.username,
    user_id: self.object.user.id}
  end
end
