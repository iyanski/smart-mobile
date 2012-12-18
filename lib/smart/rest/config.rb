module Smart
  module REST
    module Configuration
      def self.included(base)
        base.extend ClassMethods
      end
  
      module ClassMethods
        def configure(&block)
          config = self.new
          raise ArgumentError, "Please provide configuration block" unless block_given?
          yield config
      
          [:sp_id, :sp_password, :service_id, :access_code, :path_to_cert].each do |required|
            raise "#{required} is required" unless config.send(required)
          end
          config
        end
      end
    end
  end
end