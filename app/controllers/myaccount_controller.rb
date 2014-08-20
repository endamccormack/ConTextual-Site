require 'net/http'
require 'HTTParty'

class MyaccountController < ApplicationController
	def index
		render('index')
		# http://foundation.zurb.com/templates/sidebar.html
	end

	def dashboard
	end

	def account
		#@users = JSON.parse(twitter_result.body)

		@@uri = URI.parse("http://localhost:9000/API/v1/Users")

        response = Net::HTTP.get_response(@@uri)

        parsed_json_array = ActiveSupport::JSON.decode(response.body)

        @users = ActiveSupport::JSON.decode(response.body)

  		accountId = @users[0]["Account_id"]

  		accountUri = URI.parse("http://localhost:9000/API/v1/Account")

  		params = { :id => accountId}
		accountUri.query = URI.encode_www_form(params)
		res = Net::HTTP.get_response(accountUri)

		puts res.body

		@account = ActiveSupport::JSON.decode(res.body)

        render('index')
	end

	skip_before_filter  :verify_authenticity_token
	def deleteUser
		# http = Net::HTTP.new("http://localhost:9000").delete("/API/v1/User?emailAddress=" + params[:email])
		#http = Net::HTTP.new("http://localhost:9000")
		#request = Net::HTTP::Delete.new("/API/v1/User?emailAddress=" + params[:email])
		#response = http.

		# uri = URI("http://localhost:9000/API/v1/User?emailAddress=" + params[:email])
		# http = Net::HTTP.new(uri.host, uri.port)
		# theparams = { :emailAddress => params[:email]}
		# req = Net::HTTP::Delete.new(uri.path)
		# http.query = http.encode_www_form(theparams)
		# res = http.request(req)
		# puts "deleted #{res}"
		# puts "deleted #{req}"

		#note to self, dont try and use a gem that comes with rails but is designed in the 90's to do modern things, 
		#that took way too long
		HTTParty.delete("http://localhost:9000/API/v1/User", :query => {:emailAddress => params[:email]})

		#request = Net::HTTP::Delete.new("/users/1")
		#puts request
		#response = http.request(request)

		redirect_to :action => 'account'
	end

	def newUser

	end

	def createUser
		HTTParty.post("http://localhost:9000/API/v1/User", 
			:query => { :EmailAddress => params[:EmailAddress],
						:FirstName => params[:FirstName],
						:LastName => params[:LastName],
						:JobTitle => params[:JobTitle],
						:Role => params[:Role],
						:Account_id => session[:companyid],
						:password => params[:password] 
						})

		redirect_to :action => 'account'
	end


end
