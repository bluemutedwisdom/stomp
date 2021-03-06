$:.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require 'test/unit'
require 'timeout'
require 'stomp'

# Helper routines
module TestBase
  def user
    ENV['STOMP_USER'] || "guest"
  end
  def passcode
    ENV['STOMP_PASSCODE'] || "guest"
  end
  # Get host
  def host
    ENV['STOMP_HOST'] || "localhost"
  end
  # Get port
  def port
    (ENV['STOMP_PORT'] || 61613).to_i
  end
  # Helper for minitest on 1.9
  def caller_method_name
    parse_caller(caller(2).first).last
  end
  # Helper for minitest on 1.9
  def parse_caller(at)
    if /^(.+?):(\d+)(?::in `(.*)')?/ =~ at
      file = Regexp.last_match[1]
      line = Regexp.last_match[2].to_i
      method = Regexp.last_match[3]
      method.gsub!(" ","_")
      [file, line, method]
    end
  end

  # Test helper methods

  def make_destination
    name = caller_method_name unless name
    qname = ENV['STOMP_DOTQUEUE'] ? "/queue/test.ruby.stomp." + name : "/queue/test/ruby/stomp/" + name
  end

end

