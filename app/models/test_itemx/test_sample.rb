# encoding: utf-8

module TestItemx
  class TestSample < ActiveRecord::Base  
    belongs_to :test_plan
    belongs_to :manufacturer
    belongs_to :last_updated_by, :class_name => 'User'
  
    attr_accessible :test_plan_id, :qty, :unit, :name, :desp, :storage_location, :manufacturer_id,
                    :last_updated_by_id, :as => :role_new
    attr_accessible :return_date, :desp, :storage_location, :periphral_requirement, :sample_doc, :manufacturer_id,
                    :last_updated_by_id, :as => :role_update
                    
    validates_numericality_of :test_plan_id, :greater_than => 0
    validates_numericality_of :qty, :greater_than => 0, :message => '收到几个样品？'
    validates_presence_of :name, :message => '名字呢？'
    validates_presence_of :unit, :message => '个，件，套...？'
    validates_presence_of :storage_location, :message => '放哪儿了？'
   
  end
end