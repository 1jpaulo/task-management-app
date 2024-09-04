### Installation processes will differ from OSes

### Make sure you have ruby installed

### Install bundler
`$ gem install bundler`

### Install redis
`$ yay -S redis`

### Start Redis service
`$ systemctl start redis.service`

### Go to the project folder
`$ bundle install`

### Load whole schema instead of migrating
`$ rails db:schema:load`

### Load fixtures to db
`$ rails db:fixtures:load`

### Start the project
`$ rails s`

### If you want to send real emails, you will need to either change `app/mailers/application_mailer.rb` or for a global-wide change `config/environments/$RAILS_ENV.rb`

### Start sidekiq to run background notification workers
`$ bundle exec sidekiq`

### Go to localhost:3000
