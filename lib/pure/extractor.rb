require "pure/extractor/version"
require "pure/extractor/configure_puree"
require "pure/extractor/commands/pure_extractor"
require 'ruby-progressbar'
require 'pure/extractor/formatters'

module Pure
  module Extractor

    @config = {}

    def self.set_config config
      @config = config
    end
    
    def self.extract type, chunk_size, output_directory
      
      collection = Puree::Extractor::Collection.new config: @config, resource: type

      collection_count = collection.count

      puts collection_count

      progress_bar = ProgressBar.create(format: "%a %e %b\u{15E7}%i %p%% %t", progress_mark: ' ', remainder_mark: "\u{FF65}", total: collection_count)

      offset = 0
      file_id = 0

      if chunk_size.nil? || chunk_size.empty?
        chunk_size = 200
      end

      chunk_size = chunk_size.to_i

      while offset < collection_count do

        file_id += 1

        filename = type.to_s + "_#{file_id.to_s.rjust(6, '0')}"

        output_file = output_directory + "/#{filename}.json"

        returned_collection = collection.find limit: chunk_size, offset: offset

        formatted_results = format_results_for_type type, returned_collection

        write_results_to_file formatted_results, output_file

        update_progress_bar progress_bar, chunk_size, collection_count

        offset += chunk_size

      end
      
    end

    def self.format_results_for_type type, results

      formatted_results = []

      case type

        when :organisation

          formatted_results = Pure::Extractor::Formatters::OrganisationUnit.format_array results

        when :person

          formatted_results = Pure::Extractor::Formatters::Person.format_array results

        else
          byebug
          raise 'No formatter for specified area'

      end

      formatted_results

    end
    
    def self.update_progress_bar progress_bar, limit, collection_count
      
      if (progress_bar.progress + limit) < collection_count
        progress_bar.progress += limit 
      else
        progress_bar.progress = collection_count
      end
      
    end
    
    def self.write_results_to_file results, file
      
      File.open(file, "w") do |f|
        f.write(JSON.pretty_generate(results))
      end
      
    end
    
  end
end
