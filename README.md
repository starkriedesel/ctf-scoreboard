Setup
=======
1. `docker-compose up -d`
2. Server is running at http://localhost:9292

All dependencies are installed durring docker up.

Modify seed.rb for default users/tracks/flags

To get a useful console: `docker-compose run server bash -c "bundle install --path vendor/bundle && bundle exec console.rb"`