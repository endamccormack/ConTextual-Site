class AccountController < ApplicationController
	
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
end