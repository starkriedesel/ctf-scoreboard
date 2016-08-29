require 'mongoid'
require './models/user'
require './models/track'
require './models/flag'
require 'pry'

Mongoid.load!('./mongoid.yml', :development)

pry

