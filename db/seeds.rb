# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Scenario.delete_all
s1 = Scenario.create({title: '6 to 4 example', scenario_type: Scenario::SCENARIO_TYPES[0]})
c1 = s1.node.create({name: 'C1', node_type: Node::NODE_TYPES[0]})
c1i1 = c1.interface.create({ip_address: '2002:B1A9:A882:1::1', protocol: Interface::PROTOCOLS[1]})

r1 = s1.node.create({name: 'R1', node_type: Node::NODE_TYPES[1]})
r1i1 = r1.interface.create({ip_address: '2002:B1A9:A882:1::2', protocol: Interface::PROTOCOLS[1], connected_to: c1i1})
c1i1.connected_to = r1i1
c1i1.save()

r1i2 = r1.interface.create({ip_address: '177.169.168.130', protocol: Interface::PROTOCOLS[0]})

r2 = s1.node.create({name: 'R2', node_type: Node::NODE_TYPES[1]})
r2i1 = r2.interface.create({ip_address: '177.169.168.131', protocol: Interface::PROTOCOLS[0], connected_to: r1i2})
r1i2.connected_to = r2i1
r1i2.save()

r2i2 = r2.interface.create({ip_address: '2002:B1A9:A883:2::2', protocol: Interface::PROTOCOLS[1]})

c2 = s1.node.create({name: 'C2', node_type: Node::NODE_TYPES[0]})
c2i1 = c2.interface.create({ip_address: '2002:B1A9:A883:2::1', protocol: Interface::PROTOCOLS[1], connected_to: r2i2})
r2i2.connected_to = c2i1
r2i2.save()

RountingRule.delete_all
RountingRule.create({
  scenario_type: Scenario::SCENARIO_TYPES[0],
  node_type: Node::NODE_TYPES[1],
  protocol_in: Interface::PROTOCOLS[1],
  protocol_out: Interface::PROTOCOLS[0],
  script: %{function(message, node, interfaceInId) {
    var getFromHex = function(hex) {
        hex = ('0000' + hex).slice(-4);
        return parseInt(hex.substring(0, 2), 16) + '.' + 
            parseInt(hex.substring(2, 4), 16)
    }
    var dest_ip = "";
    if (message.destination.substring(0,5) != '2002:') {
        dest_ip = "192.88.99.1";
    } else {
        var splits = message.destination.split(':');
        dest_ip = getFromHex(splits[1]) + '.' + getFromHex(splits[2])
    }
    var interfaceOut = node.interface
        .findFirst(function() {return Number(this.id) !== Number(interfaceInId)});
    var source_ip = interfaceOut.ip_address;
    return new Message(source_ip, dest_ip, message);
}}
})

RountingRule.create({
  scenario_type: Scenario::SCENARIO_TYPES[0],
  node_type: Node::NODE_TYPES[1],
  protocol_in: Interface::PROTOCOLS[0],
  protocol_out: Interface::PROTOCOLS[1],
  script: %{function(message, node, interfaceInId) {
    var interfaceIn = node.interface.findFirst(function() {
        return Number(this.id) === Number(interfaceInId);
    });
    if (message.destination != interfaceIn.ip_address) {
        throw node.name + " says: This message is for interface with IP address " + message.destination + ". Mine is: " + interfaceIn.ip_address;
    }
    if (!message.message) {
        throw "Expecting package to contain IPv6 message. There is no IPv6 message.";
    }
    return message.message;
}}
})


RountingRule.create({
  scenario_type: Scenario::SCENARIO_TYPES[0],
  node_type: Node::NODE_TYPES[2],
  protocol_in: Interface::PROTOCOLS[0],
  protocol_out: Interface::PROTOCOLS[1],
  script: %{function(message, node, interfaceInId) {
    var interfaceIn = node.interface.findFirst(function() {
        return Number(this.id) === Number(interfaceInId);
    });
    if (message.destination != interfaceIn.ip_address && message.destination != '192.88.99.1') {
        throw node.name + " says: This message is for interface with IP address " + message.destination + ". Mine is: " + interfaceIn.ip_address;
    }
    if (!message.message) {
        throw "Expecting package to contain IPv6 message. There is no IPv6 message.";
    }
    return message.message;
}}
})
