require 'puree'
require 'json'

module Pure
  module Extractor
    class People
      
      def self.extract output_folder
        
        filename = "people.json"
        
        people = Puree::Collection.new resource: :person
        
        people_uuids = people.find limit: 1000000000, full: false
        
        progress_bar = ProgressBar.create(format: "%a %e %b\u{15E7}%i %p%% %t", progress_mark: ' ', remainder_mark: "\u{FF65}", total: people_uuids.count)
        
        offset = 0
        limit = 50
        
        all_people = []
      
        while offset < people_uuids.count do
          
          returned_people = people.find limit: limit, offset: offset
          
          returned_people.each do |r_person|
          
            r_person.delete("image")
            r_person.delete("keyword")
          
          end

          all_people.concat(returned_people)
          
          if (progress_bar.progress + limit) < people_uuids.count
            progress_bar.progress += limit 
          else
            progress_bar.progress = people_uuids.count
          end

          offset += limit

        end
        
        puts "Writing People to #{output_folder}/#{filename}"
        
        File.open(output_folder + "/" + filename, "w") do |f|
          f.write(all_people.to_json)
        end
        
      end
      
    end
  end
end
