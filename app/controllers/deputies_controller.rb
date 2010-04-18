class DeputiesController < ApplicationController
  def index
    @deputies = Deputy.by_initiatives
    respond_to do |wants|
      wants.html
      wants.xml { render :xml => @deputies.to_xml}
    end
  end

end
