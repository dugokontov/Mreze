class InterfacesController < ApplicationController
  # GET /interfaces
  # GET /interfaces.json
  def index
    @interfaces = Interface.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @interfaces }
    end
  end

  # GET /interfaces/1
  # GET /interfaces/1.json
  def show
    @interface = Interface.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @interface }
    end
  end
end
