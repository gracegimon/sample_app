require 'spec_helper'

describe UsersController do
 render_views

  describe "GET 'show'" do

  subject { page }

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it "should show the name" do
     should have_selector('h1',    text: user.name) 
   end

    it "should have the right title" do
     should have_selector('title', text: user.name)
   end

   it "should have the right URL" do
   #Because we're using Capybara
   should have_link(user_path(user), href: user_path(user))

   end
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
