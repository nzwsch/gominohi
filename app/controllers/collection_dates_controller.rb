class CollectionDatesController < ApplicationController
  before_action :set_collection_area

  def show
    date = params[:date].presence || Date.current

    @collection_date = @collection_area.collection_dates.with_gomi_type.where(date: date).first
  end

  def calendar
    year  = Date.current.year
    month = params[:month].presence || Date.current.month

    @collection_dates = CollectionDate.filter_by_month(year, month)
                                      .where(collection_area_id: @collection_area.id)
                                      .with_gomi_type
                                      .pluck(:date, "gomi_types.name")
                                      .map { |date, name| [date.day, name] }
                                      .to_h
                                      .to_json
  end

  private

    def set_collection_area
      @collection_area = CollectionArea.with_area_name.find(params[:collection_area_id])
    end
end
