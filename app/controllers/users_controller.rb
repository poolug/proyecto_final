class UsersController < ApplicationController
  # before_action :authenticate_user!, only: %i[ set_user show ]
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :role_select, only: %i[ new edit create update index ]
  before_action :rating_select, only: %i[ new edit create update index ]

  # GET /users or /users.json
  def index
    @users = User.includes(:housing_users).order("created_at ASC")
  end

  # GET /users/1 or /users/1.json
  def show
    self.housings_actives
    self.housings_inactives
  end

  def housings_actives
    @housings_actives = Housing.includes(:users).where({user_id: current_user.id}).where({status: "Active"})
  end

  def housings_inactives
    @housings_inactives = Housing.includes(:users).where({user_id: current_user.id}).where({status: "Inactive"})
  end

  def add_rating_member
    @user = User.find(params[:id])
    rating = params[:rating]

    respond_to do |format|
      if @user.update(rating: rating)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def rating_member
    # @user = User.find(params[:id])
    # @user = User.new
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      if User.exists?(id: params[:id])
        @user = User.find(params[:id])
      else
        flash[:notice] = "Usuario no encontrado" 
        redirect_to user_path(current_user.id) and return
      end

      if @user != User.find(current_user.id)
        flash[:alert]= 'No tienes permisos suficientes para realizar esta acción'
        redirect_to user_path(current_user.id) and return
      end
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :role, :rating, :avatar)
    end

    def role_select
      @roles = User.roles.keys.to_a
    end

    def rating_select
      @ratings = User.ratings.keys.to_a
    end
end
