require 'pure/extractor/commands/pure_command'
require 'puree'

module Pure
  module Extractor
    module Commands
      class PurePublicationsExtractorCommand < PureCommand
        
        include Pure::Extractor::ConfigurePuree
        
        def execute
          
          configure_puree server, username, password
          
          Pure::Extractor::Publications.extract output_folder
          
        end
        
      end
    end
  end
end
