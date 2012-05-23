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

  # GET /rounting_rules/new
  # GET /rounting_rules/new.json
  def new
    @rounting_rule = RountingRule.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @rounting_rule }
    end
  end

  # GET /rounting_rules/1/edit
  def edit
    @rounting_rule = RountingRule.find(params[:id])
  end

  # POST /rounting_rules
  # POST /rounting_rules.json
  def create
    @rounting_rule = RountingRule.new(params[:rounting_rule])

    respond_to do |format|
      if @rounting_rule.save
        format.html { redirect_to @rounting_rule, notice: 'Rounting rule was successfully created.' }
        format.json { render json: @rounting_rule, status: :created, location: @rounting_rule }
      else
        format.html { render action: "new" }
        format.json { render json: @rounting_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rounting_rules/1
  # PUT /rounting_rules/1.json
  def update
    @rounting_rule = RountingRule.find(params[:id])

    respond_to do |format|
      if @rounting_rule.update_attributes(params[:rounting_rule])
        format.html { redirect_to @rounting_rule, notice: 'Rounting rule was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @rounting_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rounting_rules/1
  # DELETE /rounting_rules/1.json
  def destroy
    @rounting_rule = RountingRule.find(params[:id])
    @rounting_rule.destroy

    respond_to do |format|
      format.html { redirect_to rounting_rules_url }
      format.json { head :no_content }
    end
  end
end
