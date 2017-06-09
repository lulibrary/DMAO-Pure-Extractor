require 'pure/extractor/commands/pure_command'
require 'puree'

module Pure
  module Extractor
    module Commands
      class PureExtractorCommand < PureCommand
        
        include Pure::Extractor::ConfigurePuree
        
        valid_extracts = [:organisation, :people, :projects, :publications, :datasets]
        
        parameter "EXTRACT", "what to extract from pure, valid options are #{valid_extracts.map{|v| v.to_s}}" do |s|
          
          s = s.to_sym
          
          raise ArgumentError.new("Must be a valid extract area from #{valid_extracts.map{|v| v.to_s}}") unless valid_extracts.include? s
          
          s
          
        end
        
        def pure_collections
          {organisation: :organisation, people: :person, projects: :project, publications: :publication, datasets: :dataset}
        end
        
        def execute
          
          puree_config = configure_puree server, username, password

          Pure::Extractor.set_config puree_config
            
          Pure::Extractor.extract pure_collections[extract], chunk_size, output_dir
          
        end
        
      end
    end
  end
end
