FactoryGirl.define do
  factory :user1, class: User do
    email 'user1@email.com'
    nickname 'user1'
  end

  factory :user2, class: User do
    email 'user2@email.com'
    nickname 'user2'
  end

  factory :user3, class: User do
    email 'user3@email.com'
    nickname 'user3'
  end
end
