FactoryBot.define do
  factory :keyPerson do
    trait :has_required_data do
      first_name "Kate"
      last_name "Franklin"
      position "Director"
      dob Date.new
      person_type "Relevant"
    end
  end
end
