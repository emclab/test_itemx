FactoryGirl.define do
   factory :rfq, class: 'RfqxEmc::Rfq' do 
    rfq_date                Date.current
    product_id              1
    sales_id                1
    customer_id             2
    category_id             3
    emc_eng_id              2
    safety_eng_id           2
    cust_contact_name       "a guy"
    need_report             true
    report_language         "eng"
    start_date              "2012-04-05"
    active  true
    last_updated_by_id 1
    top_secret  false
  end


end