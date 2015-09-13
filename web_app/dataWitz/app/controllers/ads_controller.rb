class AdsController < ApplicationController
  before_action :set_ad, only: [:show, :edit, :update, :destroy]
  before_filter :signed_in_user

  # GET /ads
  # GET /ads.json
  def index
    @ads = Ad.all
  end

  # GET /ads/1
  # GET /ads/1.json
  def show
  end

  # GET /ads/new
  def new
    @ad = Ad.new
  end

  # GET /ads/1/edit
  def edit
  end

  # POST /ads
  # POST /ads.json
  def create
    @ad = Ad.new(ad_params)
    @ad.user_id=current_user.id
    

    respond_to do |format|
      if @ad.save
        format.html { redirect_to @ad, notice: 'Ad was successfully created.' }
        format.json { render :show, status: :created, location: @ad }
        quikr_str={:email => @ad.email, :remoteAddr =>  "192.168.51.57",:title => @ad.title, :description=> @ad.description,:subCategory => "Mobile Phones" ,:cityName=> @ad.cityName, :locations => "Adyar", :userMobile=> @ad.userMobile , :attributes => {:Ad_Type => @ad.ad_type ,:Brand_name=>@ad.brand_name ,:Condition=> @ad.condition, :You_are => @ad.you_are }}
        quikr_json= quikr_str.to_json
        puts quikr_json
        uri = URI('https://api.quikr.com/public/postAds')
        req=Net::HTTP::Post.new(uri,initheader={'X-Quikr-App-Id' => '521','X-Quikr-Token-Id'=>'3162496','X-Quikr-Signature'=>'f3fd6d7337d4c31726ff7d0138dbeb67ffddeb54'})
        req.body=quikr_json
        res = Net::HTTP.start(uri.hostname) do |http|
  	  http.request(req).to_json
	end
	puts res
      else
        format.html { render :new }
        format.json { render json: @ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ads/1
  # PATCH/PUT /ads/1.json
  def update
    respond_to do |format|
      if @ad.update(ad_params)
        format.html { redirect_to @ad, notice: 'Ad was successfully updated.' }
        format.json { render :show, status: :ok, location: @ad }
      else
        format.html { render :edit }
        format.json { render json: @ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ads/1
  # DELETE /ads/1.json
  def destroy
    @ad.destroy
    respond_to do |format|
      format.html { redirect_to ads_url, notice: 'Ad was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ad
      @ad = Ad.find(params[:id])
    end
    

    # Never trust parameters from the scary internet, only allow the white list through.
    def ad_params
      params.require(:ad).permit(:email, :cityName, :title, :description, :user_id, :userMobile, :subCategory,:brand,:ad_type,:brand_name,:you_are,:condition)
    end
    
end
