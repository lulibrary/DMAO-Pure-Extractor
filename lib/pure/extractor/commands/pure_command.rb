require 'clamp'

module Pure
  module Extractor
    module Commands
      class PureCommand < Clamp::Command
        
        option ["-o", "--output-dir"], "output-dir", "Directory to store generated files in", required: true
        option ["-s", "--server"], "server", "Full url to Pure WS rest server", required: true
        option ["-u", "--username"], "username", "Username to connect to Pure WS"
        option ["-p", "--password"], "password", "Password to connect to Pure WS"
        option ["-c", "--chunk-size"], "chunk-size", "Number of entities to extract per file, defaults to 200"
        option ["-d", "--request-delay"], :flag, "Add random delay between sending API Requests, default to false", default: false
        option ["-i", "--interactive"], :flag, "Run in interactive mode, displaying progress bar. This is the default mode", default: false

      end
    end
  end
end
