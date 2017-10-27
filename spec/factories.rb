FactoryBot.define do
  factory :registration do
    trait :has_expires_on do
      expires_on 2.years.from_now
    end
  end
end
