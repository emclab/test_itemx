# encoding: utf-8
module TestItemx
  class TestItem < ActiveRecord::Base

    attr_accessible :name, :description, :rate, :standard_id, :active, :last_updated_by_id, :short_name, :as => :role_new
    attr_accessible :name, :description, :rate, :standard_id, :active, :last_updated_by_id, :short_name, :as => :role_update

    belongs_to :standard
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    has_many :rfq_test_items, :class_name => 'Rfqx_emc::RfqTestItem'
    has_many :rfqs, :through => :rfq_test_items, :class_name => 'Rfqx_emc::RfqTestitem'
    has_many :quote_test_items, :class_name => 'Quotex::QuoteTestItem'
    #has_many :quotes, :through => :quote_test_items, :class_name => 'Quotex::Quote'

    validates :name, :presence => true, :uniqueness => { :scope => :active, :case_sensitive => false }, :if => "active"
    validates :short_name, :presence => true, :uniqueness => { :scope => :active, :case_sensitive => false }, :if => "active"
    validates_numericality_of :standard_id, :greater_than => 0
    validates :description, :presence => true
    validates_numericality_of :rate, :greater_than => 0, :message => "收费不能为0！"

    scope :active_test_item, where(:active => true)
    scope :inactive_test_item, where(:active => false)

    protected


  end
end
