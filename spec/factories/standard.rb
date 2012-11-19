FactoryGirl.define do
  factory :standard, class: 'TestItemx::Standard' do
    name "a emc standard"
    description "details about a emc standard"
    active true
    last_updated_by_id 1
  end
end