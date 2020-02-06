require 'rest-client'
require 'json'
require 'uri'

module Antech
  module Resources
    class BaseResource
      attr_reader :auth_token

      def initialize(auth_token)
        @auth_token = auth_token
      end

      def base_url
        'https://onlineapi.antechdiagnostics.com/api'
      end

      private

      def submit(request)
        url     = request[:url]
        method  = request[:method]
        body    = request[:body] || {}
        query   = request[:query] || {}

        query = query.merge(accessToken: auth_token)

        url = "#{url}?#{URI.encode_www_form(query)}"

        response = if method == :get
                      RestClient.send(method, url)
                    else
                      RestClient.send(method, url, body)
                    end

        JSON.parse(response)
      end
    end
  end
end
