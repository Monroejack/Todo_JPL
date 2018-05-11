#spec/factories/users.rb
FactoryBot.define do
  factory :user do
    email 'user@test.com'
    password 'Password1'

    factory :user_with_tasks do
      email 'user_with_tasks@test.com'
      password 'Password1'
      after(:build) do |user|
        [:email, :homework].each do |task|
          user.tasks << FactoryBot.build(task, user: user)
        end
      end
    end
  end
end
