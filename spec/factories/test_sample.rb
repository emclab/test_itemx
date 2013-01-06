FactoryGirl.define do
  factory :test_sample, class: 'TestItemx::TestSample' do
    test_plan_id             1  
    name                    'a test sample'
    desp                    'for a test xxx'
    storage_location        'on shelf'
    qty                     1
    unit                    '2'
    manufacturer_id          1
  end
end