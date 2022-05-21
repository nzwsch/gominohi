class CollectionDatesController < ApplicationController
  before_action :set_collection_area

  def show
    date = params[:date].presence || Date.today

    @collection_date = @collection_area.collection_dates.where(date: date).first
  end

  private

    def set_collection_area
      @collection_area = CollectionArea.find(params[:collection_area_id])
    end
end
