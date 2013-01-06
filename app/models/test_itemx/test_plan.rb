# encoding: utf-8

module TestItemx
  class TestPlan < ActiveRecord::Base
    belongs_to :quote, :class_name => 'Quotex::Quote'
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    belongs_to :dept_head, :class_name => 'User'
    has_many :test_plan_logs
    has_many :test_samples

    attr_accessible :quote_id, :start_date, :finish_date, :sample_requirement, :sample_qty, :unit,:completed, :cancelled,
                    :last_updated_by_id,:as => :role_new
    attr_accessible :approved_by_dept_head, :approve_date_dept_head, :dept_head_id,
                    :reason_for_reject, :completed, :cancelled, :sample_requirement, :sample_qty, :unit,
                    :actual_start_date, :actual_finish_date, :last_updated_by_id,
                    :as => :role_update

    attr_accessor   :earliest_created_at, :latest_created_at, :eng_id_s, :sales_id_s, :customer_id_s,
                    :not_approved_by_dept_head_s
    attr_accessible :earliest_created_at, :latest_created_at, :eng_id_s, :sales_id_s, :customer_id_s,
                    :not_approved_by_dept_head_s,
                    :as => :role_search

    validates_numericality_of :quote_id, :greater_than => 0
    validates :quote_id, :uniqueness => {:scope => :cancelled }, :if => "!cancelled"
    validates :sample_requirement, :presence => true
    validates :start_date, :presence => true

    scope :approved_dept_head, lambda { |t| where('approved_by_dept_head = ?', t) }

    scope :active_test_plan, where(:cancelled => false)
    scope :cancelled_test_plan, where(:cancelled => true)

    def find_test_plans
      test_plans = TestPlan.order(:created_at)

      test_plans = test_plans.where("created_at >= ?", earliest_created_at) if earliest_created_at.present?
      test_plans = test_plans.where("created_at <= ?", latest_created_at) if latest_created_at.present?
      test_plans = test_plans.joins(:quote => :rfq).where("sales_id = ?", sales_id_s) if sales_id_s.present?
      test_plans = test_plans.joins(:quote => :rfq).where("emc_eng_id = ? OR safety_eng_id = ?", eng_id_s, eng_id_s) if eng_id_s.present?
      test_plans = test_plans.joins(:quote => :rfq).where("customer_id = ?", customer_id_s) if customer_id_s.present?
      test_plans = test_plans.where("approved_by_dept_head != :approved", :approved => true) if not_approved_by_dept_head_s.present? && not_approved_by_dept_head_s !='0'

      test_plans
    end

  end
end