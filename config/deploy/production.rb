role :app, %w{ubuntu@ec2-174-129-152-83.compute-1.amazonaws.com}
role :web, %w{ubuntu@ec2-174-129-152-83.compute-1.amazonaws.com}

server 'ec2-174-129-152-83.compute-1.amazonaws.com', user: 'ubuntu', roles: %w{web app}

set :ssh_options, {
  keys: %w(/Users/louis/Github/koin/koin.pem),
  forward_agent: false
}
