class Board < ApplicationRecord
    belongs_to :user
    has_one_attached :avatar
    has_many :tasks
end
