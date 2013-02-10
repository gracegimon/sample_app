require 'spec_helper'

describe UsersController do
 render_views

  describe "GET 'show'" do

    before(:each) do
      @user = Factory(:user)
    end

    it "should be successful" do #IT should fail, no users created to show
                                  # to solve this, using factories
      get :show, :id => @user.id
      response.should be_success
    end

    it "should find the right user" do
      # Assigns reaches the user_controller
      # uses the instance variable there
      get :show, :id => @user
      assigns(:user).should == @user
    end
  end
  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
     it "should have the right title" do
      visit signup_path
      page.should have_content("Sign up")
    end 
  end

end
