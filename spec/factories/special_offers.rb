FactoryBot.define do
  factory :special_offer do
    discount 10
    date_from DateTime.now - 1.day
    date_to DateTime.now + 1.day
  end
end
