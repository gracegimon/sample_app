class UsersController < ApplicationController
  

  def new
  	@user = User.new
  	@title = "Sign up"
  end

  def show
  	@user= User.find(params[:id])
  	@title = @user.name
  end

  def create #sign up
#   raise params[:user].inspect #This show a string rep of the obj
  	@user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user # Equivalent to user_path(@user)
    else
      @title = "Sign up"
  	  render 'new'
    end
  end
end
