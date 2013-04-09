require 'spec_helper'

describe "LayoutLinks" do
	it "should have a Home page at '/' " do
		visit root_path
		page.should have_selector('title', :content => "Home")
	end

	it "should have a Contact page at '/contact'" do
		visit contact_path
		page.should have_selector('title', :content => "Contact")
	end

	it "should have an About page at '/about'" do
		visit about_path
		page.should have_selector('title', :content => "About")
	end

	it "should have a Help page at '/help'" do
		visit help_path
		page.should have_selector('title', :content => "Help")
	end
	
	it "should have a Signup page at '/signup'" do
		visit signup_path
		page.should have_selector('title', :content => "Sign up")
	end

	it "should have a signin page at '/signin'" do
		visit signin_path
		page.should have_selector('title', :content => "Sign in")
	end
	
	it "should have a settings link" do
	  visit root_path
	  page.should have_selector('title', :content =>"Settings")
	  
  end
  
  it "should have a Users link" do
	  visit root_path
	  page.should have_selector('title', :content =>"Users")
	  
  end

	it "should have the right links on the layout" do
		visit root_path
		page.should have_selector('title', :content => "Home")
		click_link "About"
		page.should have_selector('title', :content => "About")
		click_link "Contact"
		page.should have_selector('title', :content => "Contact")
		click_link "Home"
		page.should have_selector('title', :content => "Home")
		click_link "Sign up now!"
		page.should have_selector('title', :content => "Sign up")
		page.should have_selector('a[href="/"]>img') #We want to check
													 #the link of the logo
	end

	describe "when not signed in" do
		it "should have a signin link" do
			visit root_path
			page.should have_selector("a", :href =>signin_path,
				:content => "Sign in")
		end

	end
	describe "when signed in" do
		before(:each) do
			visit signin_path
			@user = FactoryGirl.create(:user)
			fill_in :email, :with => @user.email
			fill_in :password, :with =>@user.password
			click_button "Sign in"
		end

		it "should have a signout link" do
			visit root_path
			page.should have_selector("a",:href =>signout_path,
				:content => "Sign out")
		end

		it "should have a profile link " do
			visit root_path
			page.should have_selector("a", :href => user_path(@user),
										:content => "Profile")
		end


	end

end
