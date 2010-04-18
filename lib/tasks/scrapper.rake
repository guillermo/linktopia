


desc 'Scrapp all'
task :scrapper => :environment do
  Deputy.load
  Deputy.load_details
  Deputy.load_initiatives
end
  