require 'pure/extractor/commands/pure_command'
require 'puree'

module Pure
  module Extractor
    module Commands
      class PureExtractorCommand < PureCommand

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
          
          puree_config = {
              url: server,
              username: username,
              password: password,
              collection: pure_collections[extract],
              chunk_size: chunk_size,
              output_directory: output_dir,
              delay: request_delay?
          }

          if interactive?

            Pure::Extractor::Extractors::InteractiveExtractor.set_config puree_config
            Pure::Extractor::Extractors::InteractiveExtractor.extract

          else

            Pure::Extractor::Extractors::LoggingExtractor.set_config puree_config
            Pure::Extractor::Extractors::LoggingExtractor.extract

          end


          
        end
        
      end
    end
  end
end
