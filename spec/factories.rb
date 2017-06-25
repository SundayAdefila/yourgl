FactoryGirl.define do
  factory :content do
    h1 { Faker::Lorem.sentences(rand 9) }
    h2 { Faker::Lorem.sentences(rand 9) }
    h3 { Faker::Lorem.sentences(rand 9) }
    links { [Faker::Internet.url] }
    page_url { Faker::Internet.url }
  end
end
