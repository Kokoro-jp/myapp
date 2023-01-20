FactoryBot.define do
  factory :post do
    product_img {Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpg'))}
    product_introduction {"This is a test post"}
    association :store
  end
end
