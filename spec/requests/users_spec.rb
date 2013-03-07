require 'spec_helper'

describe "Users" do
  describe "signup" do

  	describe "failure" do
  		it "should not make a new user" do
  			lambda do
  			visit signup_path
  			fill_in "Name",		  :with => "" #Fill the "Name" label with a blank
  			fill_in "Email",	  :with => ""
  			fill_in "Password",	  :with => ""
  			fill_in "Confirmation", :with => ""
  			click_button "Sign up"
  			current_path.should == "/users"
  			page.should have_selector('div#error_explanation')
  		end.should_not change(User, :count)
  		end
    end

    describe "success" do
    	it "should make a new user" do
    	  	lambda do
  			visit signup_path
  			fill_in "Name",		  :with => "Example User" #Fill the "Name" label with a blank
  			fill_in "Email",	  :with => "example@user.com"
  			fill_in "Password",	  :with => "foobar"
  			fill_in "Confirmation", :with => "foobar"
  			click_button "Sign up"
  			page.should have_selector('div.flash.success', 
  									:content => "Welcome")
  			current_path.should == "/users/1" #Inside integration test, user render
  		end.should change(User, :count).by(1)

    	end


    end

  end
end
