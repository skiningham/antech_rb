require 'antech/resources/base_resource'

module Antech
  module Resources
    class LabResult < Antech::Resources::BaseResource
      def initialize(auth_token)
        super(auth_token)
      end

      # Required query params:
      # startDate, endDate
      #
      # Optional query params:
      # petName, ownerName, doctorName, labAccessionID
      def list(query = {})
        request = {
          method: :get,
          url: "#{base_url}/v2.0/LabResults",
          query: query
        }

        submit(request)
      end

      def find(lab_accession_id)
        request = {
          method: :get,
          url: "#{base_url}/v1.1/LabResults/#{lab_accession_id}/Details"
        }

        submit(request)
      end

      def history(accession_result_id)
        request = {
          method: :get,
          url: "#{base_url}/v2.0/LabResults/History",
          query: { accessionResultId: accession_result_id }
        }
      end
    end
  end
end
