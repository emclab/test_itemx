# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :authentify_sys_user_right, class: 'Authentify::SysUserRight'  do
    sys_action_on_table_id 1
    sys_user_group_id 1
  end
end
