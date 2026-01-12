module NBA
  module DraftBoardMissingKeysHelper
    def stub_with_headers_except(key)
      headers = self.class::HEADERS.reject { |h| h == key }
      row = headers.map { |h| self.class::ROW[self.class::HEADERS.index(h)] }
      response = {resultSets: [{name: "DraftBoard", headers: headers, rowSet: [row]}]}
      stub_request(:get, /draftboard/).to_return(body: response.to_json)
    end
  end
end
