require 'yaml'
require 'pubnub-ruby'

config = YAML.load_file 'config.yaml'
pubnub = Pubnub.new(config['publish_key'], config['subscribe_key'], config['secret'], true)

get '/' do
  'Hello!'
end

post '/' do
  payload = JSON.parse(params[:payload])

  info = pubnub.publish({
    'channel' => 'push_it',
    'message' => {
      'payload' => payload
    }
  })
end
