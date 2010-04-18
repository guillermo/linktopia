class PoliticalPartiesController < ApplicationController
  def index
    
    @political_parties = PoliticalParty.with_initiatives_count
    
    respond_to do |wants|
      wants.html
      wants.xml {render :xml => @political_parties.all.to_xml}
    end
  end

end
