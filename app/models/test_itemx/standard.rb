# encoding: utf-8
module TestItemx
  class Standard < ActiveRecord::Base

    before_save :set_last_updated_by

    attr_accessor :last_updated_by_id
    attr_accessible :name, :description, :active, :as => :role_new
    attr_accessible :name, :description, :active, :as => :role_update

    has_many :test_item
    belongs_to :last_updated_by, :class_name => 'User'
    has_many :rfq_standards
    has_many :rfqs, :through => :rfq_standards

    validates :name, :presence => true, :uniqueness => { :scope => :active, :case_sensitive => false }, :if => "active"

    scope :active_std, where(:active => true)
    scope :inactive_std, where(:active => false)

    protected

    def set_last_updated_by
      self.last_updated_by = Authentify::User.find_by_id(last_updated_by_id)
    end

  end
end
