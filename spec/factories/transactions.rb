FactoryGirl.define do
  factory :transaction do |f|
    f.association :organisation          
  end
end
