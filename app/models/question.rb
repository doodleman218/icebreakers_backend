class Question < ApplicationRecord
  has_many :room_questions
  has_many :rooms, through: :room_questions
end
