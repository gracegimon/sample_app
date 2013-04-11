# == Schema Information
#
# Table name: microposts
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Micropost do
	
	before(:each) do
		@user = FactoryGirl.create(:user)
  		@attr = {:content => "lorem ipsum"}
	end

	it "should create a new instance with a valid attributes" do
		@user.microposts.create!(@attr)
	end

	describe "user associations" do
		before(:each) do
			@micropost = @user.microposts.create!(@attr)
		end

		it "should have a user" do
			@micropost.should respond_to(:user)
		end

		it "should have the right association" do
			@micropost.user_id.should == @user.id
			@micropost.user.should == @user
		end
	end

	describe "validations" do
		it "should have a user id" do
			Micropost.new(@attr).should_not be_valid
		end

		it "should require a non-blank content" do
			@user.microposts.build(:content => "  ").should_not be_valid
		end

		it "should reject long content" do
			@user.microposts.build(:content => "a " *141).should_not be_valid
		end
		
	end


end