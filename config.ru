require 'rubygems'
require 'sinatra'
require './application'

set :run, false

run Sinatra::Application
