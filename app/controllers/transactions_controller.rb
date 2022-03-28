class TransactionsController < ApplicationController
  before_action :authenticate_user!, only: %i[ set_transaction index ]
  before_action :set_transaction, only: %i[ show edit update destroy ]
  before_action :type_transaction_select, only: %i[ new edit create update index ]

  # GET /transactions or /transactions.json
  def index
    @transactions_member = transactions_current_user_member
    @housing = housing_current_user_name
    @members_current_housing = members_housing_current

    @q = Transaction.ransack(params[:q])
    @transactions_admin = @q.result.includes(:user).where(user_id: current_user.id).order(created_at: :asc).page params[:page]
  end

  def housing_current_user_name
    if User.find(current_user.id).housings.count == 0
      redirect_to root_path and return
    else
      Housing.find(@current_housing_admin).name
    end
  end

  def members_housing_current
    HousingUser.where(housing_id: @current_housing_admin)
  end

  def transactions_current_user_member
    unless User.find(current_user.id).housings.count == 0
      @current_housing_admin = HousingUser.find_by(user_id: current_user.id).housing_id
      Transaction.where(housing_id: @current_housing_admin).where(type_transaction: "Gasto_Compartido").order(created_at: :asc)
    end
  end

  def housings_actives
    @housings_actives = Housing.includes(:housing_users).where({user_id: current_user.id}).where({status: "Active"})
  end
  # GET /transactions/1 or /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
    housings_actives
  end

  # GET /transactions/1/edit
  def edit
    housings_actives
  end

  # POST /transactions or /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.user_id = current_user.id if current_user
    housings_actives

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to transactions_path, notice: "Movimiento guardado con éxito." }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1 or /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to transaction_url(@transaction), notice: "El movimiento ha sido actualizado." }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1 or /transactions/1.json
  def destroy
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to transactions_url, notice: "Movimiento eliminado." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      if Transaction.exists?(id: params[:id])
        @transaction = Transaction.find(params[:id])
      else
        flash[:notice] = "Transacción no encontrada" 
        redirect_to transactions_path and return
      end
  
      if Transaction.find(params[:id]).user_id != current_user.id
        flash[:alert]= 'No tienes permisos suficientes para realizar esta acción'
        redirect_to transactions_path and return
      end
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.require(:transaction).permit(:description, :mount, :date_transaction, :type_transaction, :housing_id, :tag_id)
    end

    def type_transaction_select
      @type_transactions = Transaction.type_transactions.keys.to_a
    end
end
