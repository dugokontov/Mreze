class RountingRulesController < ApplicationController
  # GET /rounting_rules
  # GET /rounting_rules.json
  def index
    @rounting_rules = RountingRule.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rounting_rules }
    end
  end

  # GET /rounting_rules/1
  # GET /rounting_rules/1.json
  def show
    @rounting_rule = RountingRule.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @rounting_rule }
    end
  end
  
  # GET /rounting_rules/find
  def find
    @rule = nil
    filter = params.select{|key, value| ['scenario_type', 'node_type', 'protocol_in', 'protocol_out'].include? key}
    Node::NODE_TYPES.index(params[:node_type]).downto(0) do |i|
      filter['node_type'] = Node::NODE_TYPES[i]
      puts filter['node_type']
      rule = RountingRule.where(filter).first
      return @rule = rule unless rule === nil
    end
    @rule = RountingRule.new
    @rule.script = 'function() {throw "Rule not found"}'
  end

  # GET /rounting_rules/package_constructor
  def package_constructor
    @rule = nil
    Node::NODE_TYPES.index(params[:node_type]).downto(0) do |i|
      @rule = RountingRule.where(:node_type => Node::NODE_TYPES[i]).first
      break unless @rule === nil
    end
    if @rule === nil
      @rule = RountingRule.new
      @rule.script = 'function() {throw "Rule not found"}'
    end
    render "find"
  end
end
