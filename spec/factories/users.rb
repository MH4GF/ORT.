FactoryBot.define do
  factory :user do
    email     'test@example.com'
    password  'password'
    uid       '123'
    provider  'twitter'
    name      'anonymous' 
  end
end
