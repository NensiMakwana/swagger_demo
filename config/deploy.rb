# config valid for current version and patch releases of Capistrano
lock "3.11.0"

server '13.232.45.196', port: 22, roles: [:web, :app, :db], primary: true

set :application, "swagger_demo"
set :repo_url, "git@github.com:NensiMakwana/swagger_demo.git"
set :user, 'ubuntu'

set :rvm_ruby_version, '2.3.1@swagger_demo'
set :rvm_custom_path, "/usr/share/rvm"
set :passenger_restart_with_touch, true

# Don't change these unless you know what you're doing
set :pty, true
set :use_sudo, false
set :rails_env, "production"
set :stage, :production
set :deploy_via, :remote_cache
set :deploy_to, "/home/#{fetch(:user)}/apps/#{fetch(:application)}"

set :ssh_options, { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa) }

set :branch, :master

namespace :deploy do

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart'
      invoke 'deploy'
    end
  end

  set :linked_files, %w{config/database.yml}

  after :finishing, :compile_assets
  after :finishing, :cleanup
  after :finishing, :restart
end
