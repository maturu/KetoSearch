class Food < ApplicationRecord
  def self.search(keyword)
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
      "(category = ? or name LIKE ?) and name != ?",
      food.category,
      "%#{keyword}%",
      "#{food.name}"
    )
    return results
  end
end
