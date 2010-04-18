class DashboardController < ApplicationController
  def index
    @deputies = [Deputy.by_initiatives.first, Deputy.by_initiatives.last]
    @top_deputies_by_initiatives = Deputy.by_initiatives.all(:limit => 5)
    
    @initiatives_per_candidate = Deputy.sum(:initiatives_count)/Deputy.count
    
  end

  
end
