require 'clamp'

module Pure
  module Extractor
    module Commands
      class PureCommand < Clamp::Command
        
        option ["-o", "--output-file"], "file", "file to output to", required: true
        option ["-s", "--server"], "server", "Full url to Pure WS rest server", required: true
        option ["-u", "--username"], "username", "Username to connect to Pure WS"
        option ["-p", "--password"], "password", "Password to connect to Pure WS"
        
      end
    end
  end
end
