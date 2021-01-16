FactoryBot.define do
  password = Faker::Internet.password(min_length: 6, max_length: 8)

  factory :user do
    email { Faker::Internet.email }
    password { password }
    password_confirmation { password }
    name { Faker::Lorem.characters(number:5) }
    unique_code { Faker::Lorem.characters(number:8) }
  end
  factory :admin do
    email { Faker::Internet.email }
    password { password }
    password_confirmation { password }
  end
  factory :theme do
    # fixture_file_uploadはfactorybotで使えないためRack::Test::UploadedFile.newと記載
    # やっていることは
   image { Rack::Test::UploadedFile.new('public/uploads/test.png') }
  end
end