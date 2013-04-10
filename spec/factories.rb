	 #This allows to have an user created
								# in the test environment
FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}   
    password "foobar"
    password_confirmation "foobar"
  end

  factory :micropost do
    content "Foo bar"
    association :user
  end
end
