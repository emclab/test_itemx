FactoryGirl.define do
  factory :quote, class: 'Quotex::Quote' do
    rfq_id                  1
    quoted_total            1300.00
    face_total              1500.00
    last_updated_by_id             2
    cancelled               false
    quote_date              '2012-02-12'
  end
end