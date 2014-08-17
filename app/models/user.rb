require 'digest/sha1'
require "net/http"
require "uri"
class User

   def initialize(emailAddress,firstName,lastName,jobTitle,role,account_id,password)
      @@EmailAddress = emailAddress
      @@FirstName = firstName
      @@LastName = lastName
      @@JobTitle = jobTitle
      @@Role = role
      @@Account_id = account_id
      @@password = password
   end

   def self.find(email = "")
      # gets the user data from the api given its primary key (email), if it fails it returns nil
      begin
         @email = email

         @@uri = URI.parse("http://localhost:9000/API/v1/User?email=#{email}")

         response = Net::HTTP.get_response(@@uri)

         parsed_json = ActiveSupport::JSON.decode(response.body)

         emailAddress = parsed_json["EmailAddress"]
         firstName = parsed_json["FirstName"]
         lastName = parsed_json["LastName"]
         jobTitle = parsed_json["JobTitle"]
         role = parsed_json["Role"]
         account_id = parsed_json["Account_id"]
         thepassword = parsed_json["password"]

         User.new(emailAddress, firstName, lastName, jobTitle, role, account_id, thepassword)
      rescue Exception => e 
         puts(e.message)
         nil
      end
   end

   def saveUser
      hashedPassword =  User.hash(@@password)
      @@uri = URI.parse("http://localhost:9000/API/v1/User?EmailAddress=#{@@EmailAddress}&FirstName=#{@@FirstName}&LastName=#{@@LastName}&JobTitle=#{@@JobTitle}&Role=#{@@Role}&Account_id=#{@@Account_id}&password=#{hashedPassword}")

      #POST 
   end

   def self.hash(password="")
   		Digest::SHA256.hexdigest(password)
   end

   def getEmailAddress
      @@EmailAddress
   end

   def getHashedPassword
      @@password
   end

   def getFirstName
      @@FirstName
   end


   # attr_protected :hashedPassword, :salt
   
   def self.authenticate (email="", password="")

      user = User.find(email)
      puts(user)

		#returns nil if not found
      if(user == nil)
         return false
      end

		#hashedPassword = User.hash(password)
      hashedPassword = password

		if user && user.getHashedPassword == hashedPassword
			return user
		else
			return false
		end	
   end
end
