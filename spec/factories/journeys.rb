FactoryBot.define do
  factory :journey do
    from { "lahore" }
    to { "islamabad" }
    departure_date { "27-12-2022" }
    arrival_date { "28-12-2022" }
    capacity { 20 }
    rate { 333 }
  end
end
