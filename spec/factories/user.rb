FactoryBot.define do
  factory :user, class: 'User' do
    email { 'user@example.com' }
    password { 'password' }
  end

  factory :other_user, class: 'User' do
    email { 'user1@example.com' }
    password { 'password' }
  end
end
