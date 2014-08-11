class IndexController < ApplicationController
	def index
	  render :file => 'public/index.html' and return
	end
end
