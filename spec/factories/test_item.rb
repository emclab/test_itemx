FactoryGirl.define do
  factory :test_item, class: 'TestItemx::TestItem' do
    name                   "standard name"
    short_name             'short'
    description            "description of the standard"
    active                 true
    standard_id            1
    rate                   600.00
    last_updated_by_id     1
  end
end