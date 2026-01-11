server ENV.fetch("DEPLOY_HOST"), user: ENV.fetch("DEPLOY_USER"), roles: %w[app db web]

 set :ssh_options, {
   forward_agent: true,
   auth_methods: %w[publickey]
 }
