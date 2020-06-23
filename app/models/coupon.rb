class Coupon < ApplicationRecord
  validates :signature, presence: true
  validates :price, presence: true, numericality: true
  validates :expiration_date, presence: true, format: {
    with: /\A[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])+\Z/
  }
  validates :coupon_color, presence: true, inclusion: {in: %w(gold silver bronze normal)}

  belongs_to :user
  belongs_to :review
  belongs_to :store
end
