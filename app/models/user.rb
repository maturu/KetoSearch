class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :username, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z0-9]+\Z/ }
  validates :introduction, length: { maximum: 160 }

  has_many :reviews, dependent: :destroy
  has_one :store, validate: true, dependent: :destroy
  has_many :subscribes, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable#, :omniauthable, omniauth_providers: [:twitter]
end
