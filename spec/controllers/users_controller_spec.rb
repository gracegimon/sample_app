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

  describe "POST" 'create' do

    describe "failure" do
      before(:each) do
        @attr = {:name => "", :email=> "", :password => "",
                  :password_confirmation => ""}
    end

   # it "should have the right title" do
  #    post :create, :user => @attr
    #  page.should have_selector('title', text: "Sign up")
   # end

    it "should render the 'new' page" do

      post :create, :user => @attr
      page.should render_template('new')
    end

    it "should not create a user" do
      lambda do 
        post :create, :user => @attr

      end.should_not change(User, :count) #It shouldn't add
    end


    describe "success" do

      before(:each) do
        @attr = {:name => "New User", :email=>"user@example.com",
          :password=>"foobar", :password_confirmation=>"foobar"}
      end

      it "should create a user" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1) #It should add exactly one
      end

      it "should redirect to the user show page" do
        post :create, :user => @attr
        page.should redirect_to(user_path(assigns(:user)))
        # Inside tests, we have "assigns" pulls out the @user
        # from the action
      end

      it "should have a welcome message" do
        post :create, :user =>@attr
        flash[:success].should =~ /welcome to the sample app/i
        #We just want to test for the key success in this test
      end
    end
  end #Ends describe create
 end
end
