require 'puree'

module Pure
  module Extractor
    module ConfigurePuree
      
      def configure_puree server, username, password
        
        Puree.configure do |config|
          
          config.base_url = server
          
          if !username.nil? && !password.nil? && !username.empty? && !password.empty?
            
            config.username = username
            config.password = password
            config.basic_auth = true
            
          end
          
        end
        
      end
      
    end
  end
end
