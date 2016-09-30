require "pure/extractor/version"
require "pure/extractor/configure_puree"
require "pure/extractor/commands/pure_extractor"
require 'ruby-progressbar'

module Pure
  module Extractor
    
    def self.extract type, output_file
      
      collection = Puree::Collection.new resource: type
      
      collection_count = collection.count
      
      puts collection_count
      
      progress_bar = ProgressBar.create(format: "%a %e %b\u{15E7}%i %p%% %t", progress_mark: ' ', remainder_mark: "\u{FF65}", total: collection_count)
      
      offset = 0
      limit = 20
      
      results = []
      
      while offset < collection_count do
        
        returned_collection = collection.find limit: limit, offset: offset
        
        returned_collection.each do |item|
          
          delete_keys_for_type type, item
        
        end

        results.concat(returned_collection)
        
        update_progress_bar progress_bar, limit, collection_count

        offset += limit

      end
      
      write_results_to_file results, output_file, type.to_s
      
    end
    
    def self.delete_keys_for_type type, item
      
      keys = []
      nested_keys = {}
      
      case type
        
      when :dataset
        
        keys = ["keyword", "file", "associated", "link", "spatial"]
        nested_keys = { "person" => ["external", "other"] }
        
      end
      
      keys.each do |key|
        item.delete(key)
      end
      
      nested_keys.each do |key, attribute|
        item[key].delete(attribute)
      end
      
      item
      
    end
    
    def self.update_progress_bar progress_bar, limit, collection_count
      
      if (progress_bar.progress + limit) < collection_count
        progress_bar.progress += limit 
      else
        progress_bar.progress = collection_count
      end
      
    end
    
    def self.write_results_to_file results, file, collection_name
      
      puts "Writing #{collection_name} to #{file}"
      
      File.open(file, "w") do |f|
        f.write(JSON.pretty_generate(results))
      end
      
    end
    
  end
end
