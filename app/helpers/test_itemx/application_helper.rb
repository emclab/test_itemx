# encoding: UTF-8


module TestItemx
  module ApplicationHelper


  def to_chn(str_sym)
    h = {:username => '用户名', 
      :password => '密码', 
      :password_confirmation => '确认密码',
      :user_type => '用户类型',
      :user_levels => '用户职位',
      :role => '职位',
      :updated_at => '修改时间',
      'eng' => '测试工程',
      'customer' => '客户',
      'subcontractor' => '外包商',
      'employee' => '公司员工',
      :sales => '业务员',
      :eng => '工程师',
      :search => '搜索',
      :standard => '测试标准',
      :test_item => '测试项目',
      :lease_usage_record => '测试记录单',
      :quote => '报价单',
      :invoice => '账单',
      :invoice_date => '付款日期',
      :paid_out_date => '付清日期',
      :overdue_days => '过期未付天数',
      :test_plan => '开案单',
      :customer => '客户',
      :earliest_created_at => '最早创建日期',
      :latest_created_at => '最晚创建日期',
      :category => '产品/厂家分类',
      :search_results => '搜索结果',
      :stats => '统计',
      :keyword => '关键字'}
    h[str_sym]
  end


  end
end
