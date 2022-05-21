class CollectionDatesController < ApplicationController
  before_action :set_collection_area

  def show
    date = params[:date].presence || Date.today

    @collection_date = @collection_area.collection_dates.joins(:gomi_type).select('*, gomi_types.name as gomi_type_name').where(date: date).first
  end

  private

    def set_collection_area
      @collection_area = CollectionArea.with_area_name.find(params[:collection_area_id])
    end
end
