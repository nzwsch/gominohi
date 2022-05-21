class GomiTypesController < ApplicationController
  before_action :set_collection_area

  def index
    @gomi_types = GomiType.all
  end

  def show
    @gomi_type = GomiType.find(params[:id])
    date = params[:date].presence || Date.today
    @collection_dates = CollectionDate.where(
      collection_area_id: @collection_area.id,
      gomi_type_id: @gomi_type.id,
    ).where("date > ?", date).order(date: :asc).limit(5)
  end

  private

  def set_collection_area
    @collection_area = CollectionArea.with_area_name.find(params[:collection_area_id])
  end
end
