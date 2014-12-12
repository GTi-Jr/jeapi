class ApplicationController < ActionController::API

  def validate_token  	
  	if ((Key.find_by password: params[:token]) != nil)
  		true
  	end
  end
end
