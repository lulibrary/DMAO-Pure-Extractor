require 'puree'
require 'json'

module Pure
  module Extractor
    class Organisation
      
      def self.extract output_folder
        
        filename = "organisation.json"
        
        org = Puree::Collection.new resource: :organisation
        
        org_uuids = org.find limit: 1000000000, full: false
        
        org_uuids.count
        
        offset = 0
        limit = 20
        
        orgs = []
      
        while offset < org_uuids.count do
          
          returned_orgs = org.find limit: limit, offset: offset
          
          returned_orgs.each do |r_org|
          
            r_org.delete("address")
            r_org.delete("email")
            r_org.delete("organisation")
            r_org.delete("phone")
            r_org.delete("url")
          
          end

          orgs.concat(returned_orgs)

          offset += limit

        end
        
        File.open(output_folder + "/" + filename, "w") do |f|
          f.write(orgs.to_json)
        end
        
      end
      
    end
  end
end
