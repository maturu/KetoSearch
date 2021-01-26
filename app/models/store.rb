class Store < ApplicationRecord
  validates :name, presence: true
  validates :postal_code, presence: true, format: {with: /\A[0-9]{3}-[0-9]{4}+\Z/}
  validates :address, presence: true
  validates :phone_number, presence: true, format: {with: /\A[0-9]+\Z/}

  belongs_to :user
  has_many :foods, dependent: :destroy
  has_many :subscribes, dependent: :destroy
end
