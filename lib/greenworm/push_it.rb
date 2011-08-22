module GreenWorm
  class PushIt
    def initialize commit
      return if commit['id'] == get_latest_commit_from_disk
      message = "#{commit['author']['name']} likes to PUSH IT!"
      puts ">> #{message} - #{commit['message']}"
      say message
      play_push_it
      write_commit_to_disk commit['id']
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
      begin
        File.read('last_commit.txt').chomp
      rescue
        nil
      end
    end

    def say message
      system "osascript -e 'set Volume 4' ; say -v Fred -r 200 #{message} ; osascript -e 'set Volume 3'"
    end

    def play_push_it
      system "afplay -v 5 ./push_it.mp3"
    end
  end
end
