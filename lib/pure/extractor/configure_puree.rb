module Pure
  module Extractor
    module ConfigurePuree
      
      def configure_puree server, username, password, collection, chunk_size, output_dir, delay

        {
            url: server,
            username: username,
            password: password,
            collection: collection,
            chunk_size: chunk_size,
            output_directory: output_dir,
            delay: delay
        }
        
      end
      
    end
  end
end
