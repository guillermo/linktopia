class DeputiesController < ApplicationController
  def index
    
    @deputies = Deputy.all(:order => 'initiatives_count DESC')
  end

end
