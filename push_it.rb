#!/usr/bin/env ruby

require 'yaml'
require 'awesome_print'
require 'bundler/setup'

Bundler.require(:default)

require_relative 'lib/greenworm/push_it'

$config = YAML.load_file 'config.yaml'
$redis = Redis.new(:host => $config['remote_host'])

$redis.subscribe($config['channel']) do |on|
  on.message do |channel, msg|
    data = JSON.parse(msg)
    GreenWorm::PushIt::check data['commits'].first
  end
end
