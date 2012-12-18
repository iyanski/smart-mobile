module Smart
  module REST
    class Client
      include ClassSupportMixin
      include Smart::REST::Configuration
      
      HTTP_HEADERS = {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json', 
        'Authorization' => 'WSSE realm="SDP",profile="UsernameToken"' 
      }

      set_attributes :host => 'npwifi.smart.com.ph',
        :port => 443,
        :timeout => 30,
        :retry_limit => 1,
        :sp_id => '',
        :sp_password => '', 
        :service_id => '',
        :nonce => '',
        :creation_time => '',
        :trans_id => '',
        :access_code => '',
        :mobile_number => '',
        :path_to_cert => '',
        :mobile_number => '',
        :message => ''

      
      attr_reader :sp_id, :sp_password, :sp_service_id, :nonce, :creation_time, :trans_id, :access_code, :mobile_number, :path_to_cert

      def headers
        HTTP_HEADERS.merge! ({
          'X-WSSE' => %{ "UsernameToken Username="#{self.sp_id}",PasswordDigest="#{self.sp_password}",Nonce="#{self.nonce}", Created="#{self.creation_time}"}, 
          'X-RequestHeader' => %{ "request TransId="",ServiceId="#{self.service_id}" }
        })
      end
      
      def send_sms(mobile, message)
        request = setup_connection(valid_sms_data(mobile, message).to_json)
        response = connect(request)
      end
      
      private
      
      def valid_sms_data(mobile, message)
        {"outboundSMSMessageRequest" => 
          {"address" => ["tel:#{mobile}"], 
            "senderAddress" => self.access_code,
            "outboundSMSTextMessage" => {
              "message" => "#{message}"
            }
          }
        }
      end
      
      def setup_sms_outbound_endpoint
        "https://#{self.host}/1/smsmessaging/outbound/#{self.access_code}/requests"
      end
      
      def setup_connection(args)
        uri = URI.parse(setup_sms_outbound_endpoint)
        @http = Net::HTTP.new(uri.host, uri.port)
        @http.use_ssl = true
        @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        @http.open_timeout = 3 # in seconds
        @http.read_timeout = 3 # in seconds
        
        store = OpenSSL::X509::Store.new
        store.add_cert(OpenSSL::X509::Certificate.new(File.read(self.path_to_cert)))
        @http.cert_store = store
        
        request = Net::HTTP::Post.new(uri.request_uri, initheader = headers)
        request.body = args
        request
      end
      
      def connect(request)
        response = @http.request(request)
        
        if response.body and !response.body.empty?
          object = JSON.parse(response.body)
        end
        if response.kind_of? Net::HTTPClientError
          error = Smart::REST::Response.new(object["requestError"]["serviceException"]["messageId"])
          raise error.to_s
        end
        response
      end
    end
  end
end