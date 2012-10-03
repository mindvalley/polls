class ResultsController < ApplicationController
  def index
    @results = Result.all
  end

  def show
    @results = Result.find(params[:id])
  end
end
