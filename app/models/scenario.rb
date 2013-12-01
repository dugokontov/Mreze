class Scenario < ActiveRecord::Base
  SCENARIO_TYPES = ['6to4', 'isatap']
  validates :title, :scenario_type, :presence => true
  validates :scenario_type, :inclusion => SCENARIO_TYPES 
  has_many  :node
end
