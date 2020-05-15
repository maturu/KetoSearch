class SearchController < ApplicationController
  before_action :set_variables

  def index
    @count = Food.count
  end

  def privacy_policy 
  end

  def terms
  end
end
