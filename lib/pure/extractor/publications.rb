require 'puree'
require 'json'

module Pure
  module Extractor
    class Publications
      
      def self.extract output_folder
        
        filename = "publications.json"
        
        publication = Puree::Collection.new resource: :publication
        
        publication_uuids = publication.find limit: 1000000000, full: false
        
        puts publication_uuids.count
        
        progress_bar = ProgressBar.create(format: "%a %e %b\u{15E7}%i %p%% %t", progress_mark: ' ', remainder_mark: "\u{FF65}", total: publication_uuids.count)
        
        offset = 0
        limit = 20
        
        publications = []
      
        while offset < publication_uuids.count do
          
          returned_publications = publication.find limit: limit, offset: offset
          
          returned_publications.each do |r_publication|
          
            r_publication.delete("file")
            r_publication.delete("description")
            r_publication.delete("event")
            r_publication.delete("page")
            r_publication["person"].delete("external")
            r_publication["person"].delete("other")
          
          end

          publications.concat(returned_publications)
          
          if (progress_bar.progress + limit) < publication_uuids.count
            progress_bar.progress += limit 
          else
            progress_bar.progress = publication_uuids.count
          end

          offset += limit

        end
        
        puts "Writing Publications to #{output_folder}/#{filename}"
        
        File.open(output_folder + "/" + filename, "w") do |f|
          f.write(publications.to_json)
        end
        
      end
      
    end
  end
end
