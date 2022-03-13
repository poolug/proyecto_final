class HousingsController < ApplicationController
  before_action :set_housing, only: %i[ show edit update destroy ]
  before_action :select_status, only: %i[ new edit create update index ]
  before_action :authenticate_user!, only: %i[ create new index show ]

  # GET /housings or /housings.json
  def index
    housing_current_user_id = User.where({id: current_user.id})
    @housings_actives = Housing.where({user_id: housing_current_user_id}).where({status: 0})

    @housings_inactives = Housing.where({user_id: housing_current_user_id}).where({status: 1})
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
    @housing.user_id = current_user.id if current_user

    respond_to do |format|
      if @housing.save
        housing_user = HousingUser.new
        housing_user.user_id = current_user.id
        housing_user.housing_id = Housing.last.id
        housing_user.save
        format.html { redirect_to housings_path, notice: "Housing Name: #{Housing.find(housing_user.housing_id).name} was successfully created." }
        format.json { render :show, status: :created, location: @housing }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @housing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /housings/1 or /housings/1.json
  def update
    housing_user = HousingUser.new
    housing_user.user_id = current_user.id
    housing_user.housing_id = Housing.last.id

    respond_to do |format|
      if @housing.update(housing_params)
        format.html { redirect_to housings_path, notice: "Housing Name: #{Housing.find(housing_user.housing_id).name} was successfully created." }
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
      params.require(:housing).permit(:name, :status, :inactive_at)
    end

    def select_status
      @statuses = Housing.statuses.keys.to_a
    end
end
