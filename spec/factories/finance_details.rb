FactoryBot.define do
  factory :financeDetails do
    trait :has_required_data do
      balance 100
    end
  end
end
