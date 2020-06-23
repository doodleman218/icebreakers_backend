class Room < ApplicationRecord
  has_many :questions, through: :room_questions
  has_many :users, through: :user_rooms
end
