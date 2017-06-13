module Pure
  module Extractor
    module Formatters

      class Resource

        def self.format_array array

          results = []

          array.each do |result|
            results.push format(result)
          end

          results

        end

        def self.get_system result

          {
              uuid: result.uuid,
              modified_at: result.modified
          }

        end

      end
    end
  end
end