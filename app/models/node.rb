class Node < ActiveRecord::Base
  belongs_to  :scenario
  has_many    :interface
  NODE_TYPES = ['computer', 'router', 'relay_router', 'isatap_host', 'isatap_router']
  validates :node_type, :inclusion => NODE_TYPES 
end
