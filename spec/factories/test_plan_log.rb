FactoryGirl.define do
  factory :test_plan_log, class: 'TestItemx::TestPlanLog' do
    test_plan_id            2
    content                 "test plan log content"
    last_updated_by_id      3
  end
end