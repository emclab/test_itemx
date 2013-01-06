FactoryGirl.define do
  factory :standard, class: 'Standard' do
    name "a emc standard"
    description "details about a emc standard"
    active true
    last_updated_by_id 1
  end
end