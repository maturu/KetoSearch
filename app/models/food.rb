class Food < ApplicationRecord
  validates :tag, presence: true
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: true
  validates :gram, presence: true, numericality: true
  validates :calorie, presence: true, numericality: true
  validates :protain, presence: true, numericality: true
  validates :lipid, presence: true, numericality: true
  validates :carbohydrate, presence: true, numericality: true
  validates :content, length: { maximum: 65535 }

  belongs_to :store
  has_many :reviews, dependent: :destroy
  has_many :notifications, dependent: :destroy

  def self.search(keyword)
    return nil if keyword.blank?
    split_search = keyword.split(/[[:blank:]]+/)
    results = self
    split_search.each do |ss|
      next if ss == ""
      results = results.where(['name LIKE ?', "%#{ss}%"])
    end
    return results
  end

  def self.related_search(food, keyword)
    results = Food.where(
      "(tag = ? or name LIKE ?) and name != ?",
      food.tag,
      "%#{keyword}%",
      "#{food.name}"
    )
    return results
  end

  def self.refine_search(params)
    results = Food.all
    results = results.where("tag = ?", params[:tag]) unless params[:tag].blank?
    results = results.search(params[:name]) unless params[:name].blank?
    unless params[:username].blank?
      user = User.find_by(username: params[:username])
      results = results.where("user_id = ?", user.nil? ? nil : user.id)
    end
    return results
  end
end
