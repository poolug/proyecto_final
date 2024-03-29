class HousingsController < ApplicationController
  before_action :authenticate_user!, only: %i[ set_housing index show ]
  before_action :set_housing, only: %i[ show edit update destroy ]
  before_action :select_status, only: %i[ new edit create update index ]

  # GET /housings or /housings.json
  def index
    housings_actives
    @housings_actives_member = Housing.members_on_housing.where(id: housings_current_user_member)
  end

  def housings_actives
    @housings_actives = Housing.includes(:users).where({user_id: current_user.id}).where({status: "Active"})
  end

  def housings_current_user_member
    if HousingUser.find_by(user_id: current_user.id).nil?
      redirect_to root_path and return
    else
      HousingUser.find_by(user_id: current_user.id).housing_id
    end
  end

  def housings_inactives
    @housings_inactives = Housing.includes(:users).where({user_id: current_user.id}).where({status: "Inactive"})
  end

  def add_member
    housings_actives
    @housing = params[:id]
  end

  def create_member
    email = params[:email]
    @user = User.find_by(email: email)
    @housing = params[:id]

    current_user_email = current_user.email

    if @user.present?
      @notice = "El correo ingresado ya existe"
      render "error_create_member.js.erb"
    elsif params[:email] == ""
      @notice = "Debe ingresar un correo"
      render "valid_create_member.js.erb"
    else
      @user = User.new
      @user.role = 1
      @user.email = email
      @user.name = email
      @user.password = "123456"
      @user.password_confirmation = "123456"
      @user.save!
      UserNotifierMailer.send_signup_member_email(@user, current_user_email).deliver
      
      user_housing = HousingUser.new
      user_housing.user_id = @user.id
      user_housing.housing_id = params[:housing].to_i
      user_housing.save!
      
      sleep 2
      @notice = "Usuario creado para la vivienda #{Housing.find(user_housing.housing_id).name}"
      render "create_member.js.erb"
    end
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

        format.html { redirect_to housings_path, notice: "Has creado la vivienda: #{Housing.find(housing_user.housing_id).name}" }
        format.json { render :show, status: :created, location: @housing }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @housing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /housings/1 or /housings/1.json
  def update
    housing = params[:status]
    if housing == "Inactive"
      @housing.update(inactive_at: Time.now)
    end

    respond_to do |format|
      if @housing.update(housing_params)
        format.html { redirect_to housings_path, notice: "Has editado la vivienda: #{@housing.name}" }
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
      if Housing.exists?(id: params[:id])
        @housing = Housing.find(params[:id])
      else
        flash[:notice] = "Vivienda no encontrada" 
        redirect_to housings_path and return
      end

      if Housing.find(params[:id]).user_id != current_user.id
        flash[:alert]= 'No tienes permisos suficientes para realizar esta acción'
        redirect_to housings_path and return
      end
    end

    # Only allow a list of trusted parameters through.
    def housing_params
      params.require(:housing).permit(:name, :status, :inactive_at)
    end

    def select_status
      @statuses = Housing.statuses.keys.to_a
    end
end
