require 'mongoid'
require './models/user'
require './models/track'
require './models/flag'
require './seed'
require 'pry'

Mongoid.load!('./mongoid.yml', :development)

pry

