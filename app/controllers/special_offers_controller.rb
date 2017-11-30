class SpecialOffersController < ApplicationController
  before_action :set_special_offer, only: [:show, :edit, :update, :destroy]

  # GET /special_offers
  # GET /special_offers.json
  def index
    @special_offers = SpecialOffer.all
  end

  # GET /special_offers/1
  # GET /special_offers/1.json
  def show
  end

  # GET /special_offers/new
  def new
    @special_offer = SpecialOffer.new
  end

  # GET /special_offers/1/edit
  def edit
  end

  # POST /special_offers
  # POST /special_offers.json
  def create
    @special_offer = SpecialOffer.new(special_offer_params)

    respond_to do |format|
      if @special_offer.save
        format.html { redirect_to @special_offer, notice: 'Special offer was successfully created.' }
        format.json { render :show, status: :created, location: @special_offer }
      else
        format.html { render :new }
        format.json { render json: @special_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /special_offers/1
  # PATCH/PUT /special_offers/1.json
  def update
    respond_to do |format|
      if @special_offer.update(special_offer_params)
        format.html { redirect_to @special_offer, notice: 'Special offer was successfully updated.' }
        format.json { render :show, status: :ok, location: @special_offer }
      else
        format.html { render :edit }
        format.json { render json: @special_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /special_offers/1
  # DELETE /special_offers/1.json
  def destroy
    @special_offer.destroy
    respond_to do |format|
      format.html { redirect_to special_offers_url, notice: 'Special offer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_special_offer
      @special_offer = SpecialOffer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def special_offer_params
      params.require(:special_offer).permit(:discount, :date_from, :date_to)
    end
end
