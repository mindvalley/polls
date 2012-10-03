class BallotsController < ApplicationController
  def create
    @ballot = Ballot.new(params[:ballot].merge(voter: current_user, period: current_period))

    respond_to do |format|
      if @ballot.save
        format.html { redirect_to root_url, notice: 'Ballot was successfully created.' }
      else
        format.html { redirect_to root_url, notice: 'Unable to save ballot.' }
      end
    end
  end

  def update
    @ballot = Ballot.find(params[:id])

    respond_to do |format|
      @ballot.votes.each_with_index do |vote, index|
        vote.update_attributes(params[:ballot][:votes_attributes][index])
      end
      format.html { redirect_to root_url, notice: 'Ballot was successfully updated.' }
    end
  end
end
