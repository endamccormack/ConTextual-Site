require "rubygems"
require 'net/http'

class AccountController < ApplicationController
	skip_before_filter :verify_authenticity_token
	skip_before_action :verify_authenticity_token
	
	def index
		#render(:action => 'login', :layout => 'baseLayout')
	end

	def login
		render :layout => false
	end
	#layout :resolve_layout
	def signup
		#render :layout => 
		#render('signup')#, :layout => 'application'
	end

	def attempt_signup
		uri = URI('http://localhost:9000/API/v1/Account')

		http = Net::HTTP.new(uri.host, uri.port)
		puts params[:CompanyName]
		request = Net::HTTP::Post.new(uri.request_uri)
		request.set_form_data({"CompanyName" => "My query", "per_page" => "50"})

		response = http.request(request)

		# res = Net::HTTP.post_form(uri, 'CompanyName' => params[:CompanyName])
		# puts res.body

		if authorized_user
		  session[:id] = params[:EmailAddress]
		  session[:username] = params[:FirstName]
		
		  redirect_to(:controller => 'myaccount', :action => 'index')
		else
		  flash[:notice] = "Sorry but your signup failed, please try change something and try again"
		  redirect_to(:controller => 'account', :action => 'signup')
		end

	end
	#EmailAddress:String,FirstName:String,LastName:String,JobTitle:String,Role:String,Account_id:Long,password:String
	#http://localhost:3000/signup?CompanyName=argjjnn&FirstName=knjrgjnkgrn&LastName=jnnjknjk&EmailAddress=enjjf%40ejknj.com&JobTitle=g%40g.com&password=g2g
end