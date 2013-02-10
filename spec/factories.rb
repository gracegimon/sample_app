Factory.define :user do |user| #This allows to have an user created
								# in the test environment
	user.name                  "Michael Hartl"
	user.email                 "mhartl@example.com"
	user.password              "foobar"
	user.password_confirmation "foobar"


end