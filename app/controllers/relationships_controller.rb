class RelationshipsController < ApplicationController
before_filter :authenticate

	def create 
		user = User.find(params[:relationship][:followed_id])
		current_user.follow!(user)
		flash[:success] = "You are following #{user.name}"
		redirect_to user
	end

	def destroy
		relationship = Relationship.find(params[:id]).destroy
		flash[:success] = "Unfollowed"
		redirect_to relationship.followed
	end

end