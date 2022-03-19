class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show edit update destroy ]
  before_action :type_transaction_select, only: %i[ new edit create update index ]
  before_action :authenticate_user!, only: %i[ create new show index]

  # GET /transactions or /transactions.json
  def index
    @transactions = self.transactions_current_user
  end

  def transactions_current_user
    Transaction.all.where(user_id: current_user.id).order(created_at: :asc)
  end

  # GET /transactions/1 or /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions or /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.user_id = current_user.id if current_user

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to transaction_url(@transaction), notice: "Transaction was successfully created." }
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
        format.html { redirect_to transaction_url(@transaction), notice: "Transaction was successfully updated." }
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
      format.html { redirect_to transactions_url, notice: "Transaction was successfully destroyed." }
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
      params.require(:transaction).permit(:description, :mount, :date_transaction, :type_transaction)
    end

    def type_transaction_select
      @type_transactions = Transaction.type_transactions.keys.to_a
    end
end
