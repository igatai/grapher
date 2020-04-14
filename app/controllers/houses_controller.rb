class HousesController < ApplicationController
  def index
    @houses = House.all
  end

  def import
    House.import(params[:file])
    redirect_to houses_url
  end
end
