class PoliticalParty < ActiveRecord::Base
  has_many :deputies
  
  named_scope :with_initiatives_count, {
      :select => 'SUM(deputies.initiatives_count) as initiatives_count, 
                  COUNT(deputies.id) as deputies_count,
                  (SUM(deputies.initiatives_count) / COUNT(deputies.id)) as initiatives_per_deputy,
                political_parties.*',
      :group => 'political_parties.id', 
      :joins => :deputies, :order => "initiatives_per_deputy DESC"
  }
  
  
  def initiatives_per_deputy
    initiatives_count / deputies.count.to_i
  rescue
    0
  end
  
  def initiatives_count
    deputies.sum(:initiatives_count)
  end
  
  def deputies_count
    deputies.count
  end
  
  
end
