class Manufacturer < ActiveRecord::Base
  belongs_to :last_updated_by, :class_name => 'Authentify::User'

  attr_accessible :name, :address, :active, :web,  :as => :role_new
  attr_accessible :name, :address, :web, :active, :as => :role_update
  
  validates :name, :presence => true, :uniqueness => { :scope => :active, :case_sensitive => false }, :if => "active"
  
  scope :active_mfg, where(:active => true) 
  scope :inactive_mfg, where(:active => false)  
end
