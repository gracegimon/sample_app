# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  encrypted_password :string(255)
#

class User < ActiveRecord::Base
  attr_accessor :password # Just get and set (user model objects)
  attr_accessible :email, :name, :password, :password_confirmation
  # Just the attributes that the real user can modify
email_regex= /[\w+\-.]+@[a-z\d.]+\.[a-z]+/i #The i means case insensitive
#Validation for the presence of :name
validates :name, :presence => true,
				 :length => {:maximum => 50}
validates :email, :presence => true,
				  :format => {with: email_regex},
				  :uniqueness => {:case_sensitive => false}
validates :password, :presence => true,
					 :confirmation => true,
					 :length => {:within => 6..40}
#Register a callback
#Callback: A method that's called in a particular life time of the object

before_save :encrypt_password #Before saving the user, encrypt the password

def has_password?(submitted_password)
	encrypted_password == encrypt(submitted_password)
end



private
  #Set the encrypted password of the user
	def encrypt_password
		self.salt = make_salt if new_record?
		self.encrypted_password = encrypt(password)
	end

	def encrypt(string)
		secure_hash("#{salt}--#{string}") 
	end

	def secure_hash(string)
		Digest::SHA2.hexdigest(string)
	end

	def make_salt
		secure_hash("#{Time.now.utc}--#{password}")
	end
	# class << self 
	# define class methods
	# Don't need User.
	class << self
		def User.authenticate(email, submitted_password)
			user = find_by_email(email)
			(user && user.has_password?(submitted_password)) ? user : nil
		#	return nil if user.nil?
		#	return user if user.has_password?(submitted_password)
		end

		def authenticate_with_salt(id, cookie_salt)
			user = find_by_id(id)
			(user && user.salt == cookie_salt) ? user : nil
		end
	end
end

