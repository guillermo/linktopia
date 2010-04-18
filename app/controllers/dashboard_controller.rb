class DashboardController < ApplicationController
  def index
    @deputies = [Deputy.by_initiatives.first, Deputy.by_initiatives.last]
  
    @top_deputies_by_initiatives = Deputy.by_initiatives.all(:limit => 5)
    
    @best_political_party = PoliticalParty.with_initiatives_count.first
    @worst_political_party = PoliticalParty.with_initiatives_count.last
  
    @initiatives_per_deputy = Deputy.sum(:initiatives_count)/Deputy.count
  
    @total_initiatives = Deputy.sum(:initiatives_count)
    @total_candidates_with_initiatives = Deputy.with_initiatives.count
  end

  
end
