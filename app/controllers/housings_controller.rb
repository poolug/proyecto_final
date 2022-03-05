class HousingsController < ApplicationController
  before_action :set_housing, only: %i[ show edit update destroy ]

  # GET /housings or /housings.json
  def index
    @housings = Housing.all
  end

  # GET /housings/1 or /housings/1.json
  def show
  end

  # GET /housings/new
  def new
    @housing = Housing.new
  end

  # GET /housings/1/edit
  def edit
  end

  # POST /housings or /housings.json
  def create
    @housing = Housing.new(housing_params)

    respond_to do |format|
      if @housing.save
        format.html { redirect_to housing_url(@housing), notice: "Housing was successfully created." }
        format.json { render :show, status: :created, location: @housing }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @housing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /housings/1 or /housings/1.json
  def update
    respond_to do |format|
      if @housing.update(housing_params)
        format.html { redirect_to housing_url(@housing), notice: "Housing was successfully updated." }
        format.json { render :show, status: :ok, location: @housing }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @housing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /housings/1 or /housings/1.json
  def destroy
    @housing.destroy

    respond_to do |format|
      format.html { redirect_to housings_url, notice: "Housing was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_housing
      @housing = Housing.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def housing_params
      params.fetch(:housing, {})
    end
end
