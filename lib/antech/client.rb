require "rest-client"
require "json"
require "uri"

module Antech
  class Client
    attr_reader :auth_token

    def initialize(credentials = nil)
      raise ArgumentError.new 'Credentials are required to initialize the client' if credentials.nil?

      [:clinic_id, :username, :password].each do |key|
        raise ArgumentError.new ":#{key} is required to initialize the client" if credentials[key].nil?
      end

      @auth_token = login(credentials)
    end

    private

    def login(credentials)
      response = RestClient.post(
        'https://onlineapi.antechdiagnostics.com/api/v1.1/Users/Login',
        {
          ClinicID: credentials[:clinic_id],
          UserName: credentials[:username],
          Password: credentials[:password]
        }
      )
      JSON.parse(response)['Token']
    end
  end
end
