require 'rake/deploy'


deploy.deploy_to   = "/var/www/apps/3126euros.com"
deploy.repository  = "git@github.com:guillermo/linktopia.git"
deploy.branch      = "master"
deploy.rails_env   = "production"
deploy.host        = "epifanio"
deploy.shared      = %w(/tmp /log /public/system)
deploy.user        = 'deploy'
  
after :deploy do
  puts "=> restart"
  deploy.run(deploy.host, "touch #{deploy.deploy_to}/current/tmp/restart.txt")
end
