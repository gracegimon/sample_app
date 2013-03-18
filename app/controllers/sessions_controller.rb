class SessionsController < ApplicationController
  

  def new
  	@title = "Sign in"

  end

  def create
  	user = User.authenticate(params[:session][:email],
  		params[:session][:password])
  	if user.nil?
  		flash.now[:error] = "Invalid email/password combination" #Only persists for this request
  	 	render 'new' # In case of a fail submit, re-render the sign in page
  	else
  		#Handle succesful
  	end
  end

  def destroy
  end

end
