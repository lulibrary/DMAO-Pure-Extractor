require 'puree'
require 'json'
require 'ruby-progressbar'

module Pure
  module Extractor
    class Organisation
      
      def self.extract output_folder
        
        filename = "organisation.json"
        
        org = Puree::Collection.new resource: :organisation
        
        org_uuids = org.find limit: 1000000000, full: false
        
        org_uuids.count
        
        progress_bar = ProgressBar.create(format: "%a %e %b\u{15E7}%i %p%% %t", progress_mark: ' ', remainder_mark: "\u{FF65}", total: org_uuids.count)
        
        offset = 0
        limit = 10
        
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
          
          if (progress_bar.progress + limit) < org_uuids.count
            progress_bar.progress += limit 
          else
            progress_bar.progress = org_uuids.count
          end

          offset += limit

        end
        
        puts "Writing Organisation to #{output_folder}/#{filename}"
        
        File.open(output_folder + "/" + filename, "w") do |f|
          f.write(orgs.to_json)
        end
        
      end
      
    end
  end
end
