class TrackingsController < ApplicationController
  def track
    @data = {
      "url" => request.query_string,
      "ip" => request.remote_ip,
      "location" => get_location(request.remote_ip),
      "referrer" => request.referrer,  
      "operating_system" => get_operating_system(request.env['HTTP_USER_AGENT']),
      "device" => get_device_type(request.env['HTTP_USER_AGENT']),
      "language" => request.env['HTTP_ACCEPT_LANGUAGE'],
      # "test" => request.env['HTTP_USER_AGENT']
    }
    # render json: @data

    Tracking.create(
      url: @data["url"],
      ip: @data["ip"],
      location: @data["location"],
      referrer: @data["referrer"],
      operating_system: @data["operating_system"],
      device: @data["device"],
      language: @data["language"]
    )
    render json: Tracking.all

    redirect_to request.query_string, allow_other_host: true
  end

  private
    def get_location(ip)
      require "httparty"

      url = "http://ip-api.com/json/" + ip

      location = HTTParty.get(url)

      if (location["status"]) == "success"
        return location["country"]
      else 
        return location["status"]
      end
    end

    def get_operating_system(user_agent)
      user_agent = user_agent.downcase

      if (user_agent.match(/windows/))
        return "Windows"
      elsif (user_agent.match(/linux/))
        return "Linux"
      elsif (user_agent.match(/mac/))
        return "macOS"
      elsif (user_agent.match(/iphone|ipad/))
        return "Apple iOS"
      elsif (user_agent.match(/android/))
        return "Android"
      else
        return "unknown"
      end
    end

    def get_device_type(user_agent)
      user_agent = user_agent.downcase
      if (user_agent.match(/windows|linux|mac/))
        return "desktop"
      elsif (user_agent.match(/iphone|ipad|android/))
        return "mobile"
      else
        return "unknown"
      end
    end

=begin
  # before_action :set_tracking, only: %i[ show update destroy ]

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
=end
end
