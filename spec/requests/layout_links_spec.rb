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
end
