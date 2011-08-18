#!/usr/bin/env ruby

require 'rubygems'
require 'yaml'
require 'pubnub-ruby'
require 'awesome_print'
require 'bundler/setup'

require_relative 'lib/greenworm/push_it'

config = YAML.load_file 'config.yaml'
pubnub = Pubnub.new(config['publish_key'], config['subscribe_key'], config['secret'], true)

pubnub.subscribe({
  'channel'  => 'push_it',
  'callback' => lambda do |message|
    GreenWorm::PushIt::check message['payload']['commits'].first
  end
})
