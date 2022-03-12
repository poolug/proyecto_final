class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :role_select, only: %i[ new edit create update index ]


  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    housing_current_user_id = User.where({id: current_user.id})
    @housing_current_user = Housing.where({user_id: housing_current_user_id})
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
      if User.exists?(id: (params[:id]))
        @user = User.find(params[:id])
      else
        flash[:notice] = "User not found" 
        redirect_to user_path(current_user.id)
      end
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :role)
    end

    def role_select
      @roles = User.roles.keys.to_a
    end
end
