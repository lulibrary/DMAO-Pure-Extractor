require 'pure/extractor/extractors/extractor'

module Pure
  module Extractor
    module Extractors

      class InteractiveExtractor < Extractor

        def self.extract

          collection = Puree::Extractor::Collection.new config: @config, resource: @config[:collection]

          collection_count = collection.count

          puts "Extracting #{collection_count} records from collection #{@config[:collection]}"

          progress_bar = ProgressBar.create(format: "%a %e %b\u{15E7}%i %p%% %t", progress_mark: ' ', remainder_mark: "\u{FF65}", total: collection_count)

          offset = 0
          file_id = 0

          chunk_size = get_chunk_size

          while offset < collection_count do

            random_delay if (offset != 0) && @config[:delay]

            file_id += 1

            filename = filename_for_id file_id

            output_file = output_filepath_for_filename filename

            extract_collection_to_disk collection, chunk_size, offset, output_file

            update_progress_bar progress_bar, chunk_size, collection_count

            offset += chunk_size

          end

          puts "Finished extracting #{collection_count} records from collection #{@config[:collection]}"

        end

        def self.update_progress_bar progress_bar, limit, collection_count

          if (progress_bar.progress + limit) < collection_count
            progress_bar.progress += limit
          else
            progress_bar.progress = collection_count
          end

        end

      end

    end
  end
end