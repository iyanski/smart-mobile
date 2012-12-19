require_relative 'test_helper'
require_relative '../lib/smart-mobile'

describe Smart do

  before do
    @sms = Smart::REST::SMS.new
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

  it 'should be able to send SMS' do
    begin
      response = client.send_sms("+639176004693", "Test Data")
      response.code.must_equal "201"
    rescue Exception => e
      e.message.must_equal Smart::REST::Response.new('SVC0901').to_s
    end
  end
  
  it 'should be able t send SMS using SMS Class' do
    #puts @sms.send_sms("+639176004693", "Test Data")
  end
  
  it 'should try to retry up to the max number of retry limited' do
  end
  
end