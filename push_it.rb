#!/usr/bin/env ruby

require 'rubygems'
require 'yaml'
require 'bundler/setup'

require_relative 'lib/greenworm/git_poller'

def write_latest_commit_to_disk latest_commit
  f = File.open('last_commit.txt', 'w')
  f.write latest_commit['id']
  f.close
  message = "#{latest_commit['author']['name']} likes to PUSH IT!"
  puts "\n>> #{message}"
  say message
  system "afplay -v 10 ./push_it.mp3"
end

def get_latest_commit_from_disk
  commit = File.read('last_commit.txt').chomp
end

def say message
  system "say -v Fred -r 225 #{message}"
end

config = YAML.load_file 'config.yaml'
g = GreenWorm::GitPoller.new config['login'], config['secret']

g.poll do
  latest_commit = g.client.commits('playup/Operations-API').first
  if latest_commit['id'] != get_latest_commit_from_disk
    write_latest_commit_to_disk latest_commit
  end
  print '.'
end
