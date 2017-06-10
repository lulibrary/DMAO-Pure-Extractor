require 'pure/extractor/formatters/resource'

module Pure
  module Extractor
    module Formatters

      class OrganisationUnit < Resource

        def self.format unit

          {
              system: get_system(unit),
              details: get_details(unit),
              parent: {
                  uuid: get_parent_uuid(unit)
              }
          }

        end

        def self.get_details result

          {
              name: result.name,
              description: nil,
              url: result.urls.first,
              isni: nil,
              type: result.type
          }

        end

        def self.get_parent_uuid result

          if result.parent.nil?
            nil
          else
            result.parent.uuid
          end

        end

      end

    end
  end
end