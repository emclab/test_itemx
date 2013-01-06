# encoding: utf-8

module TestItemx
  class TestPlanLog < ActiveRecord::Base
    belongs_to :test_plan
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    
    attr_accessible :test_plan_id, :content, :last_updated_by_id, :as => :role_new
    
    validates_numericality_of :test_plan_id, :greater_than => 0
    validates :content, :presence => true 
  end
end