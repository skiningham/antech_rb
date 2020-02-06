require 'antech/resources/base_resource'

module Antech
  module Resources
    class Test < Antech::Resources::BaseResource
      def initialize(auth_token)
        super(auth_token)
      end

      # Query params unknown
      def list(query = {})
        # Mystery magic params
        query.merge!({
          labID: 1,
          searchType: 6,
          orderCode: nil
        })

        request = {
          method: :get,
          url: "#{base_url}/v1.1/Tests",
          query: query
        }

        submit(request)
      end

      def find(code, code_id, lab_id)
        query = {
          testName: code,
          labID: lab_id,
          unitCode: code_id,
          searchType: 'OrderCode' # Mystery magic param
        }

        request = {
          method: :get,
          url: "#{base_url}/v1.1/Tests/Details",
          query: query
        }

        submit(request).first
      end
    end
  end
end
