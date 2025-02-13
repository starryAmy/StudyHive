class SpotsController < ApplicationController
  def update
    @spot = Spot.find(params[:id])
    @spot.status = params[:status]
    @spot.save
  end
end
