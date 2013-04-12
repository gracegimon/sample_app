class UsersController < ApplicationController
  
  before_filter :authenticate, :except => [:show, :new, :create]
   before_filter :correct_user, :only => [:edit, :update]
   before_filter :admin_user, :only => :destroy

  def index
    @users=  User.paginate(page: params[:page])
    @title= "Users"
  end
  
  
  def new
  	@user = User.new
  	@title = "Sign up"
  end

  def show
  	@user= User.find(params[:id])
    @microposts =  @user.microposts.paginate(page: params[:page])
  	@title = @user.name
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(:page => params[:page])
    render 'show_follow'

  end


  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(:page => params[:page])
    render 'show_follow'
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
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "User destroyed"
    redirect_to users_path
  end
  
  private
  

    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      user = User.find(params[:id])
      redirect_to(root_path) unless (current_user.admin? && !current_user?(@user))
    end
  
  
end
