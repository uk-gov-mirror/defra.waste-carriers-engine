FactoryBot.define do
  factory :registration do
    trait :has_expiresOn do
      expiresOn 2.years.from_now
    end
  end
end
