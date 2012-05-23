class Interface < ActiveRecord::Base
  belongs_to  :node
  belongs_to  :connected_to, :class_name => 'Interface'
  PROTOCOLS = ['ipv4', 'ipv6']
end
