require 'spec_helper'

describe PagesController do
 render_views

  before(:each) do
    @base_title = "Ruby on Rails Tutorial Sample App"
  end
  describe "GET 'home'" do

    describe "when not signed in" do
      it "returns http success" do
        visit root_path
        response.should be_success
      end

      it "should have this content" do
        visit  root_path
        page.should have_content("#{@base_title} | Home")
      end

      it "should have a non-blank body" do
        visit root_path
        response.body.should_not =~ /<body>\s*<\/body>/
      end

    end

    describe "when signed in" do
        before(:each) do
          @user = test_sign_in(FactoryGirl.create(:user))
          other_user = FactoryGirl.create(:user)
          other_user.follow!(@user)
        end

        it "should have the right follower/following count" do
          get :home
          response.should have_selector('a', :href => following_user_path(@user),
                        :content => "0 following")
          response.should have_selector('a', :href => followers_user_path(@user),
                        :content => "1 follower")

        end

    end

  end

  describe "GET 'contact'" do
    it "returns http success" do
      get 'contact'
      response.should be_success
    end
    it "should have the right title" do
      	visit contact_path
        page.should have_selector('title',
                    :text => "#{@base_title} | Contact")
     end
  end

  describe "GET 'about'" do
    it "returns http success" do
      get 'about'
      response.should be_success
    end
  end

  describe "GET 'help'" do
    it "returns http success" do
      get 'help'
      response.should be_success
    end
    it "should have the right title" do
      visit help_path
      page.should have_selector('title',
                    :text => "#{@base_title} | Help")
   end
  end
end
