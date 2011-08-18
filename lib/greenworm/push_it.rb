module GreenWorm
  class PushIt
    def initialize commit
      return if commit['id'] == get_latest_commit_from_disk

      write_commit_to_disk commit['id']

      message = "#{commit['author']['name']} likes to PUSH IT!"

      puts "\n>> #{message} - #{commit['message']}"
      say message
      play_push_it
    end

    def self.check commit
      self.new commit
    end

    private

    def write_commit_to_disk commit
      f = File.open('last_commit.txt', 'w')
      f.write commit
      f.close
    end
 
    def get_latest_commit_from_disk
      commit = File.read('last_commit.txt').chomp
    end

    def say message
      system "say -v Fred -r 200 #{message}"
    end

    def play_push_it
      system "afplay -v 10 ./push_it.mp3"
    end
  end
end