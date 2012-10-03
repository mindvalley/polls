class HomeController < ApplicationController
  def index
    @entries = Entry.valid
    unless @ballot = Ballot.where(voter: current_user, period: current_period).first
      @ballot = Ballot.new 
      @entries.each do |entry|
        @ballot.votes.build(candidate: entry.id)
      end
    end
    #raise @entries.entries.inspect
  end
end
