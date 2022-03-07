class HousingUsersController < ApplicationController
  before_action :set_housing_user, only: %i[ show edit update destroy ]

  # GET /housing_users or /housing_users.json
  def index
    @housing_users = HousingUser.all
  end

  # GET /housing_users/1 or /housing_users/1.json
  def show
  end

  # GET /housing_users/new
  def new
    @housing_user = HousingUser.new
  end

  # GET /housing_users/1/edit
  def edit
  end

  # POST /housing_users or /housing_users.json
  def create
    @housing_user = HousingUser.new(housing_user_params)
    
    respond_to do |format|
      if @housing_user.save
        format.html { redirect_to housing_user_url(@housing_user), notice: "Housing user was successfully created." }
        format.json { render :show, status: :created, location: @housing_user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @housing_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /housing_users/1 or /housing_users/1.json
  def update
    respond_to do |format|
      if @housing_user.update(housing_user_params)
        format.html { redirect_to housing_user_url(@housing_user), notice: "Housing user was successfully updated." }
        format.json { render :show, status: :ok, location: @housing_user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @housing_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /housing_users/1 or /housing_users/1.json
  def destroy
    @housing_user.destroy

    respond_to do |format|
      format.html { redirect_to housing_users_url, notice: "Housing user was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_housing_user
      @housing_user = HousingUser.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def housing_user_params
      params.require(:housing_user).permit(:user_id, :housing_id)
    end
end
