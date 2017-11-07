FactoryBot.define do
  factory :registration do
    metaData { build(:metaData) }

    trait :has_expiresOn do
      expiresOn 2.years.from_now
    end

    trait :is_pending do
      metaData { build(:metaData, status: :pending) }
    end

    trait :is_active do
      metaData { build(:metaData, status: :active) }
    end

    trait :is_revoked do
      metaData { build(:metaData, status: :revoked) }
    end

    trait :is_refused do
      metaData { build(:metaData, status: :refused) }
    end

    trait :is_expired do
      metaData { build(:metaData, status: :expired) }
    end
  end

  factory :metaData do
  end
end
