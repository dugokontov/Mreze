class ScenariosController < ApplicationController
  # GET /scenarios
  # GET /scenarios.json
  def index
    @scenarios = Scenario.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @scenarios }
    end
  end

  # GET /scenarios/1
  # GET /scenarios/1.json
  def show
    @scenario = Scenario.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @scenario.to_json({
        only: [:title, :scenario_type], include: {
          node: {only: [:name, :node_type], include: {
            interface: {only: [:id, :ip_address, :protocol, :connected_to_id]}
          }}
        }
      })}
    end
  end
end
