require 'clamp'

module Pure
  module Extractor
    module Commands
      class PureCommand < Clamp::Command
        
        option ["-o", "--output-file"], "file", "file to output to, when extracting all this is the folder to place output files", required: true
        option ["-s", "--server"], "server", "Full url to Pure WS rest server", required: true
        option ["-u", "--username"], "username", "Username to connect to Pure WS"
        option ["-p", "--password"], "password", "Password to connect to Pure WS"
        
      end
    end
  end
end
