class SearchController < ApplicationController
  def index
    @count = Food.count
  end

  def privacy_policy 
  end

  def terms
  end
end
