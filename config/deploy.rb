# frozen_string_literal: true
# config valid only for current version of Capistrano
lock '3.6.0'

set :application, 'leuphana'
set :repo_url, 'git@github.com:AKRAPolska/leuphana.git'

ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :scm, :git
set :format, :airbrussh

set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('log',
                                               'tmp/pids',
                                               'tmp/cache',
                                               'tmp/sockets',
                                               'vendor/bundle',
                                               'public/client',
                                               'public/uploads',
                                               'config/settings')

namespace :deploy do
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end
end
