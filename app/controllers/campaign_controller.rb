class CampaignController < ApplicationController
	def index
		@@uri = URI.parse("http://localhost:9000/API/v1/Campaigns?Account_id=" + session[:companyid].to_i.to_s )

        response = Net::HTTP.get_response(@@uri)

        parsed_json_array = ActiveSupport::JSON.decode(response.body)

        @campaigns = ActiveSupport::JSON.decode(response.body)

        render('index')
	end

	def new
		
	end

	def delete
		HTTParty.delete("http://localhost:9000/API/v1/Campaign", :query => {:id => params[:id]})
		redirect_to :action => 'index'
	end

	skip_before_filter  :verify_authenticity_token
	def create
		HTTParty.post("http://localhost:9000/API/v1/Campaign", 
			:query => { :Name => params[:Name],
						:Description => params[:Description],
						:Account_id => session[:companyid].to_i.to_s
						})

		redirect_to :action => 'index'
		
	end
end
