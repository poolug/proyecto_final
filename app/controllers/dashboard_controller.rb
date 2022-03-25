class DashboardController < ApplicationController
  def index
    @tiempo = Time.now

    mes_actual = Time.now.month

    @ingresos_mes_actual = Transaction.group_by_month(:date_transaction, format: "%m-%Y").where('EXTRACT(MONTH FROM date_transaction) = ? ', mes_actual).where('type_transaction = ? ', 0).sum(:mount)

    @gastos_mes_actual = Transaction.group_by_month(:date_transaction, format: "%m-%Y").where('EXTRACT(MONTH FROM date_transaction) = ? ', mes_actual).where('type_transaction = ? ', 1).sum(:mount)

    @ingresos_ultimos_meses = Transaction.group_by_month(:date_transaction, format: "%m-%Y").where('EXTRACT(MONTH FROM date_transaction) < ? ', 12.month).where(user_id: current_user.id).where('type_transaction = ? ', 0).sum(:mount)

    type_transactions
  end

  def type_transactions
    types = Transaction.type_transactions.to_a
    @ingreso = types[0][1].to_i
    @gasto =  types[1][1].to_i
    @gasto_compartido =  types[2][1].to_i
  end
  
end
