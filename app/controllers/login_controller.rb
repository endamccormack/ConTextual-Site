#for some reason there is a bug with rendering different layouts for different actions in the same controller so I had to seperate it from account
class LoginController < ActionController::Base
	layout 'baseLayout'

	def login
		#render :layout => 'baseLayout'
		#,  :template => 'baseLayout'
	end

end
