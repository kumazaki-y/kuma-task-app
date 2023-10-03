class Task < ApplicationRecord
  belongs_to :user
  belongs_to :board
  has_one_attached :eye_catch
end
