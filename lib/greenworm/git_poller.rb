require 'octokit'

module GreenWorm
  
  class GitPoller
    attr_reader :client
    
    def initialize login=nil, secret=nil, poll_interval=30
      raise 'Need login and secret!' if login.nil? | secret.nil?
      @login = login
      @secret = secret 
      @poll_interval = poll_interval
      @client = Octokit::Client.new(:login => login, :token => secret)
    end
    
    def poll
      while true
        yield
        sleep @poll_interval
      end
    end
  
  end

end
