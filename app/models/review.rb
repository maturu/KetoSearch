class Review < ApplicationRecord
  validates :review_title, presence: true
  validates :review_details, presence: true
  validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1
  }, presence: true

  belongs_to :user
  belongs_to :food
  has_one :coupon, dependent: :destroy
end
