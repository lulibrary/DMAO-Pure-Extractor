require 'pure/extractor/commands/pure_command'
require 'puree'

module Pure
  module Extractor
    module Commands
      class PureExtractorCommand < PureCommand
        
        valid_extracts = [:organisation, :people]
        
        parameter "EXTRACT", "what to extract from pure" do |s|
          
          s = s.to_sym
          
          raise ArgumentError.new("Must be a valid extract area from #{valid_extracts.map{|v| v.to_s}}") unless valid_extracts.include? s
          
          s
          
        end
        
        def execute
          
          Puree.configure do |config|
            
            config.base_url = server
            
            if !username.empty? && !password.empty?
              
              config.username = username
              config.password = password
              config.basic_auth = true
              
            end
            
          end
        
          case extract
            
          when :organisation
          
            Pure::Extractor::Organisation.extract output_folder
            
          end
          
        end
        
      end
    end
  end
end
