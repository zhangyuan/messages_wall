# -*- encoding : utf-8 -*-
require "bundler/capistrano"
require 'puma/capistrano'

server = ENV["MESSAGES_WALL_SERVER"]

unless server
  puts "Please set MESSAGES_WALL_SERVER variable"
  exit
end

default_run_options[:pty] = true

set :default_environment, {
    'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
}
set :application, "wechat_helper"
set :repository,  "git@github.com:zhangyuan/messages_wall.git"

set :scm, :git
set :branch, "master"
set :deploy_via, :remote_cache
ssh_options[:forward_agent] = true


server server, :web, :app, :db, :primary => true

set :user, 'deploy'

set :use_sudo, false
set :deploy_to, "/home/#{user}/apps/#{application}"

after "deploy", "deploy:cleanup"

set :puma_socket, "unix:///tmp/#{application}.sock"

namespace :deploy do
  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/secrets.yml #{release_path}/config/secrets.yml"
    run "ln -nfs #{shared_path}/config/newrelic.yml #{release_path}/config/newrelic.yml"
    run "ln -nfs #{shared_path}/public/uploads #{release_path}/public/uploads"
  end

  desc "Sync the public/assets directory."
  task :assets_sync do
    system('bundle exec rake assets:precompile')
    find_servers(:roles => :web).each do |s|
      system "rsync -vr --exclude='.DS_Store' public/assets #{user}@#{s}:#{release_path}/public/"
    end
    system('rm -rf public/assets')
  end

  task :precompile_assets, :roles => :web do 
    run "cd #{release_path}; RAILS_ENV=production bundle exec rake assets:precompile RAILS_ENV=production"
  end

  after "deploy:update_code", "deploy:symlink_config", "deploy:migrate", "deploy:precompile_assets"
end
