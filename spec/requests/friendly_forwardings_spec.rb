require 'spec_helper'

describe "FriendlyForwardings" do
  

    it "should forward to the requested page after signin" do
      user = FactoryGirl.create(:user)
      visit edit_user_path(user)
      fill_in :email, :with => user.email
      fill_in :password, :with => user.password
      click_button "Sign in"
      # edit_user_path(user)
      visit signout_path
      visit signin_path
      fill_in :email, :with => user.email
      fill_in :password, :with => user.password
       click_button "Sign in"
    end

end
