class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :title, presence: true
  validates :content, presence: true
  validates :deadline, presence: true

  has_many :boards, dependent: :destroy
  has_many :tasks, dependent: :destroy

  def has_written?(board)
    boards.exists?(id: board.id)
  end

end
