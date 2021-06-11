class AirlinesController < ApplicationController
  def show
    @airline = Airline.find(params[:id])
    @passengers = @airline.adult_passengers
  end
end
