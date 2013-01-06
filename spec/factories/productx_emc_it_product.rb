# encoding: utf-8
FactoryGirl.define do
  factory :productx_emc_it_product, class: 'ProductxEmcIt::Product' do
    name                "a emc test product"
    model                   "A435"
    tech_spec           "tech spec for a product"
  end
end