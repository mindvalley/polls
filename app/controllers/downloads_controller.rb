class DownloadsController < ApplicationController
  def voters
    period = params[:period]
    voters = User.all_who_voted(period)
    send_data User.to_csv(voters), filename: "voters_for_period_#{params[:period]}.csv"
  end
end