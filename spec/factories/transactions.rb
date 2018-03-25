FactoryGirl.define do
  factory :transaction do |f|
    f.association :organisation
    amount { rand(100020) }
  end
end
