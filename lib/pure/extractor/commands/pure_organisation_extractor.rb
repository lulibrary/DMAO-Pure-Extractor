require 'pure/extractor/commands/pure_command'
require 'puree'

module Pure
  module Extractor
    module Commands
      class PureOrganisationExtractorCommand < PureCommand
        
        def execute
          
          Puree.configure do |config|
            
            config.base_url = server
            
            if !username.empty? && !password.empty?
              
              config.username = username
              config.password = password
              config.basic_auth = true
              
            end
            
          end
          
          Pure::Extractor::Organisation.extract output_folder
          
        end
        
      end
    end
  end
end
