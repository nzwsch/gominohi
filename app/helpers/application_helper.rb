module ApplicationHelper
  WEEKDAYS = %w[日 月 火 水 木 金 土].freeze

  def page_date
    @page_date ||= begin
      date = params.fetch(:date, nil)
      !date.nil? ? Date.parse(date) : Date.today
    end
  end

  def collection_date_title
    weekday = WEEKDAYS[page_date.wday]
    page_date.strftime("%-m月%-d日(#{weekday})の収集品目")
  end
end
