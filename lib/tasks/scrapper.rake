

namespace :scrapper do
  
  desc "Scrapping of diputy list"
  task :deputy => :environment do
    Deputy.load
    
    puts "There are #{Deputy.count} deputies"
  end
  
  desc "Scrapping of each diputy information"
  task :deputy_information => :environment do
    Deputy.load_details
  end
  
  desc "Scrapping of each deputy initiatives"
  task :deputy_initiatives => :environment do
    Deputy.load_initiatives
  end
    
end

desc 'Scrapp all'
task :scrapper=> ['scrapper:deputy', 'scrapper:deputy_information']
  
   