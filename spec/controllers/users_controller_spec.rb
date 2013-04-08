require 'spec_helper'

describe UsersController do
 render_views

 describe "GET index" do
   
   describe "for non-signed-in users" do
     it "should deny access " do
       get :index
       response.should redirect_to(signin_path)
     end
     
   end

   describe "for signed-in users" do
     
     before(:each) do
       @user = test_sign_in(FactoryGirl.create(:user))
       FactoryGirl.create(:user, :email =>"another@example.com")
     end
     
      it "should be successful " do
        get :index
        response.should be_success
      end
      
      it "should have an element for each user" do
        get :index
        User.all.each do |user|
          response.should have_selector('li', :content => user.name)     
        end
        
      end

    end
   
   
 end


  describe "GET 'show'" do

  subject { page }

  describe "profile page" do
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

      it "should sign the user in" do
        post :create, :user => @attr
        controller.should be_signed_in

      end
    end
  end #Ends describe create
  end
  
  describe "GET 'edit'" do
   before(:each) do
    @user = FactoryGirl.create(:user)
    test_sign_in(@user)
   end
    
    it "should be succesful" do
      get :edit, :id => @user
      response.should be_success
    end
    
 #  it "should have the right title" do
  #    get :edit, :id => @user
  #    response.should have_content("Edit")
  #  end
    
  it "should have a link to change the Gravatar" do
     visit edit_user_path(@user)
     page.should have_selector('a', :href => 'http://gravatar.com/emails',
                                        :content => "change") 
  end
      
  end
  

  
  describe "PUT 'update'" do
    
    before(:each) do
      @user = FactoryGirl.create(:user)
      test_sign_in(@user)
    end
    
    describe "failure" do
      
      before(:each) do
          @attr = {:name => "", :email=> "", :password => "",
                    :password_confirmation => ""}
      end
      
      it "should render the edit page" do
        put :update, :id => @user, :user => @attr
        response.should render_template('edit')
      end
      
      
    end
    
    
    describe "success" do
      
      before(:each) do
        @attr = {:name => "New User", :email=>"user@example.com",
          :password=>"foobar", :password_confirmation=>"foobar"}
      end
      
      it "should change the user's attributes" do
        put :update, :id => @user, :user => @attr
        user = assigns(:user) # Picks it from the controller
        @user.reload #pulls from the database
        @user.name.should == user.name
        @user.email.should == user.email
        @user.encrypted_password.should == user.encrypted_password
      end
      
      it "should have a flash message" do
        put :update, :id => @user, :user => @attr
        flash[:success].should =~ /updated/
        
      end
      
    end
    
  end
  
  describe "authentication of edit/update actions" do
    
    before(:each) do
     @user = FactoryGirl.create(:user)
    end
    
    describe "for non-signed-in users" do
      it "should deny access to 'edit'" do
           get :edit, :id => @user
            response.should redirect_to(signin_path)
            flash[:notice].should =~ /sign in/i
      end

      it "should deny access to 'update'" do
       put :update, :id => @user, :user => []
       response.should redirect_to(signin_path)

      end
      
    end

    describe "for signed-in users" do
      
      before(:each) do
       wrong_user = FactoryGirl.create(:user, :email =>"user@example.net")
       test_sign_in(wrong_user)
      end
      
      it " should require matching users for 'update'" do
        get :edit, :id => @user, :user => {}
        response.should redirect_to(root_path)
        
      end
      
      
      it " should require matching users for 'edit'" do
        put :update, :id => @user
        response.should redirect_to(root_path)
        
      end
      
      
    end
    
    
    
  end
  
end
