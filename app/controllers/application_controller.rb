class ApplicationController < ActionController::API

  def validate_token  
  	if ((Key.find_by password: request.headers["token"]) != nil)
  		true
  	else
  		head :unauthorized
  	end
  end
end
