class UsersController < ApplicationController
  
  before_filter :authenticate, :only => [:edit, :update]

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
  
  #If somebody tries to edit, it should be signed in.. > BeforeFilter
  def edit
    @user = User.find(params[:id])
    @title = "Edit"
  end
  
  def update
    @user = User.find(params[:id])
    if  @user.update_attributes(params[:user])
      redirect_to @user, :flash => {:success => "Profile updated"}
    else
      @title = "Edit"
      render 'edit'
    end
  end
  
  private
  
    def authenticate
      deny_access unless signed_in?
    end
    
  
  
end
