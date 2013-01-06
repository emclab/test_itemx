FactoryGirl.define do
  factory :test_plan, class: 'TestItemx::TestPlan' do
    quote_id                2
    start_date              '2012-5-20'
    finish_date             '2012-6-3'
    cancelled               false
    completed               false
    sample_requirement      'something'
  end  
end