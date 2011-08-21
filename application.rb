require 'yaml'
require 'redis'
require 'json'

$config = YAML.load_file 'config.yaml'
$redis = Redis.new

get '/' do
  'Hello!'
end

post '/' do
  payload = JSON.parse(params[:payload])
  $redis.publish $config['channel'], payload.to_json
end
