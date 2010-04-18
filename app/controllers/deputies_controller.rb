class DeputiesController < ApplicationController
  def index
    
    @deputies = Deputy.by_initiatives
  end

end
