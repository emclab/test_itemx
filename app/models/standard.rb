# encoding: utf-8

  class Standard < ActiveRecord::Base


    attr_accessible :name, :description, :active, :last_updated_by_id, :as => :role_new
    attr_accessible :name, :description, :active, :last_updated_by_id, :as => :role_update

    has_many :test_item
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    has_many :rfq_standards, :class_name => 'Rfqx::RfqStandard'
    has_many :rfqs, :through => :rfq_standards, :class_name => 'Rfqx::Rfq'

    validates :name, :presence => true, :uniqueness => { :scope => :active, :case_sensitive => false }, :if => "active"

    scope :active_std, where(:active => true)
    scope :inactive_std, where(:active => false)

    protected


  end

