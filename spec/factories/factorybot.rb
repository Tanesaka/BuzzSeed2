FactoryBot.define do
  password = Faker::Internet.password(min_length: 6, max_length: 8)

# unique_codeは自動生成される
  factory :user do
    email { Faker::Internet.email }
    password { password }
    password_confirmation { password }
    name { Faker::Lorem.characters(number: 5) }
    # メール認証をパスするための記述
    confirmed_at { Date.today }
  end
  factory :admin do
    email { Faker::Internet.email }
    password { password }
    password_confirmation { password }
  end
  factory :information do
    association :admin
    content { Faker::Lorem.characters(number: 20) }
  end
  factory :theme do
    association :user
    # fixture_file_uploadはfactorybotで使えないためRack::Test::UploadedFile.newと記載
    # やっていることは同じ
    image { Rack::Test::UploadedFile.new('public/uploads/test.png') }
  end
  factory :answer do
    association :theme
    user { theme.user }
    content { Faker::Lorem.characters(number: 20) }
  end
  factory :comment do
    association :answer
    user { answer.user }
    content { Faker::Lorem.characters(number: 20) }
  end
  factory :favorite do
    association :answer
    user { answer.user }
  end
  factory :relation do
    association :user
    association :follow, factory: :user
  end
end
