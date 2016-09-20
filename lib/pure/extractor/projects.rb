require 'puree'
require 'json'

module Pure
  module Extractor
    class Projects
      
      def self.extract output_folder
        
        filename = "projects.json"
        
        project = Puree::Collection.new resource: :project
        
        project_uuids = project.find limit: 1000000000, full: false
        
        puts project_uuids.count
        
        progress_bar = ProgressBar.create(format: "%a %e %b\u{15E7}%i %p%% %t", progress_mark: ' ', remainder_mark: "\u{FF65}", total: project_uuids.count)
        
        offset = 0
        limit = 50
        
        projects = []
      
        while offset < project_uuids.count do
          
          returned_projects = project.find limit: limit, offset: offset
          
          returned_projects.each do |r_project|
          
            r_project.delete("url")
            r_project.delete("description")
            r_project["person"].delete("external")
            r_project["person"].delete("other")
          
          end

          projects.concat(returned_projects)
          
          if (progress_bar.progress + limit) < project_uuids.count
            progress_bar.progress += limit 
          else
            progress_bar.progress = project_uuids.count
          end

          offset += limit

        end
        
        puts "Writing Projects to #{output_folder}/#{filename}"
        
        File.open(output_folder + "/" + filename, "w") do |f|
          f.write(projects.to_json)
        end
        
      end
      
    end
  end
end
