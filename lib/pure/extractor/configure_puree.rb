require 'puree'

module Pure
  module Extractor
    module ConfigurePuree
      
      def configure_puree server, username, password

        {
            url: server,
            username: username,
            password: password
        }
        
      end
      
    end
  end
end
