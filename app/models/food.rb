class Food < ApplicationRecord
  validates :tag, presence: true
  validates :name, presence: true, uniqueness: true
  validates :gram, presence: true, numericality: true
  validates :calorie, presence: true, numericality: true
  validates :protain, presence: true, numericality: true
  validates :lipid, presence: true, numericality: true
  validates :carbohydrate, presence: true, numericality: true
  #validates :water, numericality: true
  #validates :fibtg, numericality: true
  #validates :na, numericality: true
  #validates :reference, presence: true
  #validates :url, presence: true
  validates :content, length: { maximum: 65535 }

  belongs_to :user

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
end
