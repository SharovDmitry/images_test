FactoryBot.define do
  factory :user

  factory :image do
    user
    width { 200 }
    height { 200 }
    file { File.open(Rails.root.join('spec/fixtures/images/file.gif')) }
  end
end
