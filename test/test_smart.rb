require_relative 'test_helper'
require_relative '../lib/smart'

describe Smart do

  before do
    @sms = Smart::REST::SMS.new
  end
  
  def valid_sms_data
    {"outboundSMSMessageRequest" => 
      {"address" => ["tel:+639176230655"], 
        "senderAddress" => config_file['access_code'].to_s,
        "outboundSMSTextMessage" => {
          "message" => "Test Message"
        }
      }
    }
  end

  def client
    @client ||= initialize_rest_client 
  end

  def initialize_rest_client
    Smart::REST::Client.configure do |config|
      config.sp_id = config_file['sp_id']
      config.sp_password = config_file['sp_password'].to_s
      config.service_id = config_file['service_id']
      config.access_code = config_file['access_code'].to_s
      config.path_to_cert = config_file['path_to_cert']
      config.creation_time = config_file['creation_time']
      config.nonce = config_file['nonce']
    end
  end

  it 'should not allow for invalid sp_password' do
    begin
      response = client.send_sms(valid_sms_data)
    rescue Exception => e
      e.message.must_equal Smart::REST::Response.new('SVC0901').to_s
    end
  end
  
  it 'should have a valid certificate' do

  end
  
  it 'should try to retry up to the max number of retry limited' do
  end
  
end