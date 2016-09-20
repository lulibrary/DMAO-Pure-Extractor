require 'puree'
require 'json'

module Pure
  module Extractor
    class Datasets
      
      def self.extract output_folder
        
        filename = "datasets.json"
        
        dataset = Puree::Collection.new resource: :dataset
        
        dataset_uuids = dataset.find limit: 1000000000, full: false
        
        puts dataset_uuids.count
        
        progress_bar = ProgressBar.create(format: "%a %e %b\u{15E7}%i %p%% %t", progress_mark: ' ', remainder_mark: "\u{FF65}", total: dataset_uuids.count)
        
        offset = 0
        limit = 1
        
        datasets = []
      
        while offset < 1 do
          
          returned_datasets = dataset.find limit: limit, offset: offset
          
          returned_datasets.each do |r_dataset|
          
            r_dataset.delete("keyword")
            r_dataset.delete("file")
            r_dataset.delete("associated")
            r_dataset.delete("link")
            r_dataset.delete("spatial")
            r_dataset["person"].delete("external")
            r_dataset["person"].delete("other")
          
          end

          datasets.concat(returned_datasets)
          
          if (progress_bar.progress + limit) < dataset_uuids.count
            progress_bar.progress += limit 
          else
            progress_bar.progress = dataset_uuids.count
          end

          offset += limit

        end
        
        puts "Writing Datasets to #{output_folder}/#{filename}"
        
        File.open(output_folder + "/" + filename, "w") do |f|
          f.write(datasets.to_json)
        end
        
      end
      
    end
  end
end
