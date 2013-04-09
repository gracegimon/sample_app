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
              fill_in "Name",     :with => "Example User" #Fill the "Name" label with a blank
              fill_in "Email",    :with => "example@user.com"
              fill_in "Password",   :with => "foobar"
              fill_in "Confirmation", :with => "foobar"
              click_button "Sign up"
              page.should have_selector('div.flash.success', 
                          :content => "Welcome")
              current_path.match(/\/users\/\d+/) #Inside integration test, user render
            end.should change(User, :count).by(1)
        end

      end

  end


  describe "signin" do
    
    describe "failure" do
      it "should not sign in an invalid user" do
        visit signin_path
        fill_in "Email", :with =>""
        fill_in "Password", :with =>""
        click_button "Sign in"
        page.should have_selector('div.flash.error', :content =>"Invalid")
        current_path.should == "/sessions"
      end
    end

    describe "success" do

      it "should sign a user in and out" do
        user = FactoryGirl.create(:user)
        visit signin_path
        fill_in "Email", :with => user.email
        fill_in "Password", :with => user.password
        click_button "Sign in"
  #      controller.should be_signed_in
        click_link "Sign out"
   #     controller.should_not be_signed_in
      end
    end

  end
end

