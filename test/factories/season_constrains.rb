require 'factory_girl'

FactoryGirl.define do
  factory :season_constrain do

    starts_at { Time.now - 1.hour }

    trait(:expires_past_tomorrow) do
      ends_at { Time.now + 2.day }
    end

    trait(:expired) do
      starts_at { Time.now - 2.days }
      ends_at   { Time.now - 1.day }
    end

    trait(:expires_in_23_hours) do
      ends_at { Time.now + 23.hours }
    end

  end
end
