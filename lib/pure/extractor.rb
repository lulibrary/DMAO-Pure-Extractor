require "pure/extractor/version"
require "pure/extractor/configure_puree"
require "pure/extractor/commands/pure_extractor"
require 'ruby-progressbar'
require 'byebug'

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

          results.each do |result|

            if result.parent.nil?
              parent_uuid = nil
            else
              parent_uuid = result.parent.uuid
            end

            formatted_result = {
                system: {
                    uuid: result.uuid,
                    modified_at: result.modified
                },
                details: {
                    name: result.name,
                    description: nil,
                    url: result.urls.first,
                    isni: nil,
                    type: result.type
                },
                parent: {
                    uuid: parent_uuid
                }
            }

            formatted_results.push formatted_result

          end

        when :person

          results.each do |result|

            formatted_result = {
                system: {
                    uuid: result.uuid,
                    modified_at: result.modified
                },
                details: {
                    first_name: result.name.first,
                    last_name: result.name.last,
                    email: result.email_addresses.first,
                    image_url: result.image_urls.first,
                    orcid: result.orcid
                }
            }

            formatted_results.push formatted_result

          end

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
