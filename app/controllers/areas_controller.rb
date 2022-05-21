class AreasController < ApplicationController
  def index
    @areas = Area.includes(:collection_areas).order(:id)
  end
end
