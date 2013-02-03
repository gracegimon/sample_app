# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :email, :name 
  # Just the attributes that the user
  # can modify
email_regex= /[\w+\-.]+@[a-z\d.]+\.[a-z]+/i #The i means case insensitive
#Validation for the presence of :name
validates :name, :presence => true,
				 :length => {:maximum => 50}
validates :email, :presence => true,
				  :format => {with: email_regex},
				  :uniqueness => {:case_sensitive => false}


end
