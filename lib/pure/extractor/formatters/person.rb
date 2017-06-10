require 'pure/extractor/formatters/resource'

module Pure
  module Extractor
    module Formatters

      class Person < Resource

        def self.format unit

          {
              system: get_system(unit),
              details: {
                  first_name: unit.name.first,
                  last_name: unit.name.last,
                  email: unit.email_addresses.first,
                  image_url: unit.image_urls.first,
                  orcid: unit.orcid
              }
          }

        end

      end

    end
  end
end