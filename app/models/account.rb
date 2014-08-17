require 'digest/sha1'
require "net/http"
require "uri"
class Account
   def initialize(id)
    @@id = id
    @@uri = URI.parse("http://localhost:9000/API/v1/Account?id=#{id}")

    response = Net::HTTP.get_response(@@uri)

    #Net::HTTP.get_print(@@uri)
    puts(response.body)
    parsed_json = ActiveSupport::JSON.decode(response.body)

    puts()

    @@id = parsed_json["id"]
    @@companyName = parsed_json["CompanyName"]
  end

  def getId
    @@id
  end

  def getCompanyName
    @@companyName
  end
end
