class Room < ApplicationRecord
  has_many :room_questions
  has_many :questions, through: :room_questions
  has_many :user_rooms
  has_many :users, through: :user_rooms
end
