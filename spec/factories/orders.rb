FactoryGirl.define do
  factory :order do

    Status "Pending"
    total 234
    vat 45
    delivery_cost 500
    association :user
    transaction_id "123"
    invoice "3"
  end
end
