require 'mina/bundler'
require 'mina/git'

set :version, "{{ vx_worker_version }}"
set :deploy_to, "{{ vx_home }}/worker"

set :domain, 'worker.example.com'
set :repository, 'git://github.com/vexor/vx-worker.git'
set :branch, 'master'

set :user, '{{ vx_user }}'

task :environment do
  queue %{
    #{ echo_cmd %{export PATH={{ vx_home }}/bin:$PATH} }
  }
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    invoke :'git:clone'
    queue %{
      bundle install --path=#{deploy_to}/shared/bundle --without test --jobs 4
    }
    to :launch do
      invoke :'deploy:cleanup'
    end
  end
end
