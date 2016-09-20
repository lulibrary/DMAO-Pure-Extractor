require 'pure/extractor/commands/pure_command'
require 'puree'

module Pure
  module Extractor
    module Commands
      class PureExtractorCommand < PureCommand
        
        include Pure::Extractor::ConfigurePuree
        
        valid_extracts = [:organisation, :people, :projects, :publications, :datasets, :all]
        
        parameter "EXTRACT", "what to extract from pure, valid options are #{valid_extracts.map{|v| v.to_s}}" do |s|
          
          s = s.to_sym
          
          raise ArgumentError.new("Must be a valid extract area from #{valid_extracts.map{|v| v.to_s}}") unless valid_extracts.include? s
          
          s
          
        end
        
        def pure_collections
          {organisation: :organisation, people: :person, projects: :project, publications: :publication, datasets: :dataset}
        end
        
        def execute
          
          configure_puree server, username, password
        
          case extract
            
          when :all
            
            valid_extracts.each do |extract|
              
              next unless extract != :all
              
              filename = output_file + "/" + extract.to_s + ".json"
              
              Pure::Extractor.extract pure_collections[extract], filename
              
            end
            
          else
            
            Pure::Extractor.extract pure_collections[extract], output_file
            
          end
          
        end
        
      end
    end
  end
end
