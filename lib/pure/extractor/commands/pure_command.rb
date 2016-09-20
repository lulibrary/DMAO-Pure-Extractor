require 'clamp'

module Pure
  module Extractor
    module Commands
      class PureCommand < Clamp::Command
        
        option ["-o", "--output-folder"], "folder", "folder to output to", required: true
        option ["-s", "--server"], "server", "Full url to Pure WS rest server", required: true
        option ["-u", "--username"], "username", "Username to connect to Pure WS", required: true
        option ["-p", "--password"], "password", "Password to connect to Pure WS", required: true
        
      end
    end
  end
end
