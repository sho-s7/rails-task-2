class Room < ApplicationRecord
  belongs_to :user
  has_many :reservations, dependent: :destroy
  has_one_attached :avatar
  validates :name, presence: true
  validates :detail, presence: true
  validates :fee, presence: true, numericality: {greater_than_or_equal_to: 1}
  validates :address, presence: true
end
