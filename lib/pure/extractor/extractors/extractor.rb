module Pure
  module Extractor
    module Extractors

      class Extractor

        @config = {}

        def self.set_config config
          @config = config
        end

        def self.extract_collection_to_disk collection, chunk_size, offset, output_file

          returned_collection = collection.find limit: chunk_size, offset: offset

          formatted_results = format_results_for_type @config[:collection], returned_collection

          write_results_to_file formatted_results, output_file

        end

        def self.random_delay

          random_timeout = 60 + Random.rand(120)

          sleep(random_timeout)

        end

        def self.format_results_for_type type, results

          begin
            formatter = Module.const_get('Pure::Extractor::Formatters::' + type.to_s.capitalize)
            formatter.format_array results
          rescue NameError
            raise 'No formatter for specified area'
          end

        end

        def self.write_results_to_file results, file

          File.open(file, "w") do |f|
            f.write(JSON.pretty_generate(results))
          end

        end

        def self.filename_for_id id
          @config[:collection].to_s + "_#{id.to_s.rjust(6, '0')}"
        end

        def self.output_filepath_for_filename filename
          @config[:output_directory] + "/#{filename}.json"
        end

        def self.get_chunk_size

          chunk_size = @config[:chunk_size]

          if chunk_size.nil? || chunk_size.empty?
            chunk_size = 200
          end

          chunk_size.to_i

        end

      end

    end
  end
end