class PaymentController < ApplicationController

	def index
		@@uri = URI.parse("http://localhost:9000/API/v1/PaymentDetails?Account_id=" + session[:companyid].to_i.to_s )
        response = Net::HTTP.get_response(@@uri)
        parsed_json_array = ActiveSupport::JSON.decode(response.body)
        @paymentDetails = ActiveSupport::JSON.decode(response.body)

        render('index')
	end

	def delete
		HTTParty.delete("http://localhost:9000/API/v1/PaymentDetail", :query => {:id => params[:id]})
		redirect_to :action => 'index', :Account_id => session[:companyid].to_i.to_s 
	end

	def new
		
	end

	skip_before_filter  :verify_authenticity_token
	def create
		HTTParty.post("http://localhost:9000/API/v1/PaymentDetail", 
			:query => { :CardNumber => params[:CardNumber],
						:ExpiryDate => params[:ExpiryDate],
						:CardHolderName => params[:CardHolderName],
						:CSV => params[:CSVNumber],
						:CardType => params[:CardType],
						:Account_id => session[:companyid].to_i.to_s
						})

		redirect_to :action => 'index', :Account_id => session[:companyid].to_i.to_s 
		# Context:String,Title:String, Content:String, campaign_id:Long
	end

end
