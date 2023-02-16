FactoryBot.define do
  factory :post do
    product_img { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/test.jpg')) }
    product_introduction { 'This is a test post' }
    association :store
  end
end
