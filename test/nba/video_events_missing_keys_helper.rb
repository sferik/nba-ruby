require_relative "../test_helper"

module NBA
  module VideoEventsMissingKeysHelper
    def stub_with_headers_except(key, headers_constant, row_constant)
      headers = headers_constant.reject { |h| h == key }
      row = headers.map { |h| row_constant[headers_constant.index(h)] }
      response = {resultSets: [{headers: headers, rowSet: [row]}]}
      stub_request(:get, /videoevents/).to_return(body: response.to_json)
    end
  end
end
