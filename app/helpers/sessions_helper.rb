module SessionsHelper
#These helpers are available just in views for default

 def sign_in(user)
 	#Uses the salt to identify the user using a string
 	cookies.permanent.signed[:remember_token] = [user.id, user.salt]
 	current_user = user
 	#Permanent means 20 years from now..
 end

 def current_user=(user) # SETTER METHOD
 	@current_user = user
 end

 def current_user
 	@current_user ||= user_from_remember_token
 #Assigns to current_user user_from_remember_token if current_user is nil
 # so it won't hit the database numerous times
 end

 def signed_in?
 	!current_user.nil?
 end

 def sign_out
 	cookies.delete(:remember_token)
 	current_user = nil
 end
 
 def deny_access
   flash[:notice] = "Please sign in to access this page"
   redirect_to signin_path
 end

 private 

 	def user_from_remember_token
 		User.authenticate_with_salt(*remember_token)
 	end

 	def remember_token
 		cookies.signed[:remember_token] || [nil,nil]
 	end



end
