class TrackingsController < ApplicationController
  before_action :set_tracking, only: %i[ show update destroy ]

  # GET /trackings
  def index
    @trackings = Tracking.all

    render json: @trackings
  end

  # GET /trackings/1
  def show
    render json: @tracking
  end

  # POST /trackings
  def create
    @tracking = Tracking.new(tracking_params)

    if @tracking.save
      render json: @tracking, status: :created, location: @tracking
    else
      render json: @tracking.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /trackings/1
  def update
    if @tracking.update(tracking_params)
      render json: @tracking
    else
      render json: @tracking.errors, status: :unprocessable_entity
    end
  end

  # DELETE /trackings/1
  def destroy
    @tracking.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tracking
      @tracking = Tracking.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tracking_params
      params.require(:tracking).permit(:url, :ip, :location, :referrer, :operating_system, :device, :language)
    end
end
