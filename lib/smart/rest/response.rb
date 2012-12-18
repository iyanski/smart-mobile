module Smart
  module REST
    class Response
      attr_reader :response_code
      #TODO:
      # Service Exception Extension	
      # Policy Exceptions	
      # Policy Exception Extension	    
      @@error_map = {
        :condition_not_met? => 304,
        :invalid_request_parameters? => 400,
        :authentication_failed? => 401,
        :not_permitted? => 403,
        :not_found? => 404,
        :method_not_allowed? => 405,
        :conflict? => 409,
        :content_length_required? => 411,
        :precondition_failed? => 412,
        :request_body_too_large? => 413,
        :invalid_range? => 416,
        :internal_server_error? => 500,
        :server_busy? => 503,
        :service_error? => 'SVC0001',
        :invalid_input_value? => 'SVC0002',
        :invalid_input_value_with_valid_values? => 'SVC0003',
        :no_valid_address? => 'SVC0004',
        :duplicate_correlator? => 'SVC0005',
        :invalid_group? => 'SVC0006',
        :invalid_charging_info? => 'SVC0007',
        :overlapping_criteria? => 'SVC0008',
        :success? => 200,
        :created? => 201,
        :no_content? => 204,
        :password_not_accepted? => 'SVC0901'
      }
      
      @@status_messages = {
        304 => "ConditionNotMet - Not Modified: The condition specified in the conditional header(s) was not met for a read operation.",
        400 => "Invalid parameters in the request",
        401 => "Authentication failure",
        403 => "Application does not have permissions to access resource due to the policy constraints (request rate limit, etc)",
        404 => "Not Found - The specified resource does not exist.",
        405 => "Method not allowed by the resource",
        409 => "Conflict",
        411 => "Length Required: The Content-Length header was not specified.",
        412 => "Precondition Failed: The condition specified in the conditional header(s) was not met for a write operation.",
        413 => "RequestBodyTooLarge - Request Entity Too Large: The size of the request body exceeds the maximum size permitted.",
        416 => "InvalidRange - Requested Range Not Satisfiable: The range specified is invalid for the current size of the resource.",
        500 => "Internal server error",
        503 => "ServerBusy - Service Unavailable: The server is currently unable to receive requests. Please retry your request.",
        "SVC0001" => "Service Error",
        "SVC0002" => "Invalid input value",
        "SVC0003" => "Invalid input value with list of valid values",
        "SVC0004" => "No valid addresses",
        "SVC0005" => "Duplicate correlator",
        "SVC0006" => "Invalid group",
        "SVC0007" => "Invalid charging information",
        "SVC0008" => "Overlapping Criteria",
        "SVC0901" => "Sp password is not accepted!",
        200 => "Success",
        201 => "Created",
        204 => "No Content"
      }
      
      def initialize(code)
        @response_code = code
      end
      
      def valid?
        [200, 201].include?(self.response_code)
      end
      
      def to_s
        #"#{self.response_code} - #{msg}"
        msg
      end
      
      def msg(code = self.response_code)
        if msg = @@status_messages[code]
          msg
        else
          raise ArgumentError, "#{code} - undefined response code"
        end
      end
      
      def method_missing(method_id)
        if code = @@error_map[method_id.to_sym]
          self.response_code == code
        else
          raise NoMethodError
        end
      end
    end
  end
end