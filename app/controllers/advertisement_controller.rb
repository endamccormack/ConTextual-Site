class AdvertisementController < ApplicationController
	def index
		@@uri = URI.parse("http://localhost:9000/API/v1/Ads?Campaign_id="+ params[:Campaign_id].to_i.to_s)
        response = Net::HTTP.get_response(@@uri)
        parsed_json_array = ActiveSupport::JSON.decode(response.body)
        @ads = ActiveSupport::JSON.decode(response.body)
        render('index')
	end

	def delete
		HTTParty.delete("http://localhost:9000/API/v1/Ad", :query => {:id => params[:id]})
		redirect_to :action => 'index', :Campaign_id => params[:Campaign_id] 
	end

	def new

	end

	skip_before_filter  :verify_authenticity_token
	def create
		HTTParty.post("http://localhost:9000/API/v1/Ad", 
			:query => { :Context => params[:Context],
						:Title => params[:Title],
						:Content => params[:Content],
						:campaign_id => params[:Campaign_id].to_i.to_s
						})

		redirect_to :action => 'index', :Campaign_id => params[:Campaign_id].to_i.to_s
		# Context:String,Title:String, Content:String, campaign_id:Long
	end
end