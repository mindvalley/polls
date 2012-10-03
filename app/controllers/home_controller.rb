class HomeController < ApplicationController
  def index
    @employees = Employee.votable
    unless @ballot = Ballot.where(voter: current_user, period: current_period).first
      @ballot = Ballot.new 
      @employees.each do |employee|
        @ballot.votes.build(candidate: employee.id)
      end
    end
  end
end
