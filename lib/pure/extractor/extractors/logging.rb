require 'pure/extractor/extractors/extractor'

module Pure
  module Extractor
    module Extractors

      class LoggingExtractor < Extractor

        def self.extract

          collection = Puree::Extractor::Collection.new config: @config, resource: @config[:collection]

          collection_count = collection.count

          puts "Extracting #{collection_count} records from #{@config[:collection]} collection"

          offset = 0
          file_id = 0

          chunk_size = get_chunk_size

          number_of_files = get_number_of_files collection_count

          while offset < collection_count do

            random_delay if (offset != 0) && @config[:delay]

            file_id += 1

            if (offset + chunk_size) > collection_count
              to_records = collection_count
            else
              to_records = offset + chunk_size
            end

            puts "Extracting records #{offset} - #{to_records} to file #{file_id} of #{number_of_files}"

            filename = filename_for_id file_id

            output_file = output_filepath_for_filename filename

            extract_collection_to_disk collection, chunk_size, offset, output_file

            puts "Extracted records to #{output_file}"

            offset += chunk_size

          end

          puts "Finished extracting #{collection_count} records from collection #{@config[:collection]}"

        end

        def self.get_number_of_files collection_count

          full_files, remaining_records = collection_count.divmod(get_chunk_size)

          return full_files if remaining_records == 0

          full_files + 1

        end

      end

    end
  end
end