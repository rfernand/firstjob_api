module FirstjobApi
  class HttpParser
    def self.parse_json_to_hash(json, hash)
      json.each{|object| hash[object["id"]] ? hash[object["id"]].merge!(object) : hash[object["id"]] = object}
      return hash
    end

    def self.parse_response(response)
      FirstjobApi.last_response = response
      FirstjobApi.last_request = response.request
      case response.code
        when 200..201
          # "All good!"
          return response.body
        when 401
          FirstjobApi.invalidate_access_token!
          raise "Error 401: Unauthorized. Check login info.\n #{response.body}"
        when 403
          raise "Error 403: Forbidden"
        when 404
          raise "Error 404 not found"
        when 500...600
          raise "ZOMG ERROR #{response.code}: #{response.request.path}, #{response.body}"
        else
          raise "Error #{response.code}, unkown response: #{response.request.path}, #{response.body}"
      end
    end
    def self.parse_json_response(response)
      FirstjobApi.last_response = response
      FirstjobApi.last_request = response.request
      case response.code
        when 200..201
          # "All good!"
          return JSON.parse(response.body)
        when 401
          FirstjobApi.invalidate_access_token!
          raise "Error 401: Unauthorized. Check login info.\n #{response.body}"
        when 403
          raise "Error 403: Forbidden"
        when 404
          raise "Error 404 not found"
        when 500...600
          raise "ZOMG ERROR #{response.code}: #{response.request.path}, #{response.body}"
        else
          raise "Error #{response.code}, unkown response: #{response.request.path}, #{response.body}"
      end
    end
  end
end
