FactoryBot.define do
  factory :item_order do
    postal_code { '111-1111' }
    prefecture_id { 2 }
    city         { '台東区' }
    addresses    { '5−30−10' }
    building     { 'ビル' }
    phone_number { 0o311111111 }

    number       { 4_242_424_242_424_242 }
    exp_month    { 3 }
    exp_year     { 23 }
    cvc          { 123 }
    token        { 'tok_abcdefghijk00000000000000000' }
  end
end
