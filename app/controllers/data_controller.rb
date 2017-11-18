class DataController < ApplicationController

  def index
    @data = Datum.all
  end
     
  def show
      @datum = Datum.find(params[:id])
  end
  
end

