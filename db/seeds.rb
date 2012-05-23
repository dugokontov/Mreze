# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Scenario.delete_all
s1 = Scenario.create({title: '6 to 4', scenario_type: Scenario::SCENARIO_TYPES[0]})
c1 = s1.node.create({name: 'C1', node_type: Node::NODE_TYPES[0]})
c1i1 = c1.interface.create({ip_address: '192.168.1.2', protocol: Interface::PROTOCOLS[0]})

r1 = s1.node.create({name: 'R1', node_type: Node::NODE_TYPES[1]})
r1i1 = r1.interface.create({ip_address: '192.168.1.1', protocol: Interface::PROTOCOLS[0], connected_to: c1i1})
c1i1.connected_to = r1i1
c1i1.save()

r1i2 = r1.interface.create({ip_address: '192.168.0.1', protocol: Interface::PROTOCOLS[0]})

r2 = s1.node.create({name: 'R2', node_type: Node::NODE_TYPES[1]})
r2i1 = r2.interface.create({ip_address: '192.168.0.2', protocol: Interface::PROTOCOLS[0], connected_to: r1i2})
r1i2.connected_to = r2i1
r1i2.save()

r2i2 = r2.interface.create({ip_address: '192.168.2.1', protocol: Interface::PROTOCOLS[0]})

c2 = s1.node.create({name: 'C2', node_type: Node::NODE_TYPES[0]})
c2i1 = c2.interface.create({ip_address: '192.168.2.2', protocol: Interface::PROTOCOLS[0], connected_to: r2i2})
r2i2.connected_to = c2i1
r2i2.save()
