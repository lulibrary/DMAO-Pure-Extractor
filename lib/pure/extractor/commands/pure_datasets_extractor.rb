require 'pure/extractor/commands/pure_command'
require 'puree'

module Pure
  module Extractor
    module Commands
      class PureDatasetsExtractorCommand < PureCommand
        
        include Pure::Extractor::ConfigurePuree
        
        def execute
          
          configure_puree server, username, password
          
          Pure::Extractor::Datasets.extract output_folder
          
        end
        
      end
    end
  end
end
