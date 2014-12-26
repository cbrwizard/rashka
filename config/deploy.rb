# config valid only for current version of Capistrano
lock '3.3.5'

set :application, 'rashka'
set :repo_url, 'https://github.com/cbrwizard/rashka.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call


set :rails_env, :production

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

desc 'Upload database.yml file'
task :setup do
  on roles(:app) do
    execute "mkdir -p #{shared_path}/config"
    upload! StringIO.new(File.read("config/database.yml")), "#{shared_path}/config/database.yml"
  end
end
