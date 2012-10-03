module ApplicationHelper
  def current_period
    date = Date.today << 1
    "#{date.strftime("%Y-%m")}"
  end
end
