module ApplicationHelper
  WEEKDAYS = %w[日 月 火 水 木 金 土].freeze

  def page_date
    @page_date ||= begin
      date = params.fetch(:date, nil)
      !date.nil? ? Date.parse(date) : Date.today
    end
  end


  def page_month
    @this_month ||= begin
      today = Date.today
      year  = today.year # FIXME
      month = (params.fetch(:month, nil).presence || today.month).to_i
      Date.new(year, month, 1) # withZone
    end
  end

  def collection_date_title
    weekday = WEEKDAYS[page_date.wday]

    page_date.strftime("%-m月%-d日(#{weekday})の収集品目")
  end

  def active_if_today(class_string = '')
    is_today = params[:date].to_s.empty? || params[:date] == Date.today.to_s

    is_today ? "#{class_string} active" : class_string
  end

  def active_if_this_month(class_string = '')
    is_this_month = params[:month].to_s.empty? || params[:month] == this_month.to_s

    is_this_month ? "#{class_string} active" : class_string
  end

  def this_year
    page_month.year
  end

  def prev_month
    page_month.prev_month.month
  end

  def this_month
    page_month.month
  end

  def next_month
    page_month.next_month.month
  end

end
