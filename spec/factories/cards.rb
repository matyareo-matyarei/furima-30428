FactoryBot.define do
  factory :card do
    association :user
    card_token        { 'tok_abcdefghijk00000000000000000' }
    customer_token    { 'cus_abcdefghijk00000000000000000' }

  end
end