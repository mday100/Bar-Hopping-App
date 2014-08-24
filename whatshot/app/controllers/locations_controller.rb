class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]
  before_filter :require_login, except: [:index, :show, :foursquare]
  skip_before_filter :verify_authenticity_token 
  respond_to :html, :js

  def index
    if params[:search].present?
      @locations = Location.near(params[:search], 50, :order => "distance")
    else
      @locations = Location.all
      
      @geojson = Array.new

      @locations.each do |location|
        @geojson << {
          type: 'Feature',
          geometry: {
            type: 'Point',
            coordinates: [location.longitude, location.latitude]
          },
          properties: {
            name: location.id,
            address: location.address,
            :'marker-color' => '#FF0000',
            :'marker-symbol' => 'fire-station',
            :'marker-size' => 'medium'
          }
        }
      end

      respond_to do |format|
        format.html
        format.json { render json: @geojson }
      end
    end
  end

  def show
    @location = Location.find(params[:id])
  end

  def new
    @location = Location.new
  end

  def edit
  end

  def create
    @location = Location.new(location_params)
  end

  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url, notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:address, :latitude, :longitude)
    end
end
