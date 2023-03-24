class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @tiempo = Time.now
    mes_actual = Time.now.month
    type_transactions
    @housing = transactions_current_user_admin

    @ingresos = Transaction.where('EXTRACT(MONTH FROM date_transaction) = ? ', mes_actual).where('type_transaction = ? ', 0).where(user_id: current_user.id).sum(:mount)

    @gastos = Transaction.where('EXTRACT(MONTH FROM date_transaction) = ? ', mes_actual).where('type_transaction = ? ', 1).where(user_id: current_user.id).sum(:mount)

    # ingresos, admin
    @ingresos_mes_actual = Transaction.group_by_month(:date_transaction, format: "%m-%Y", time_zone: false).where('EXTRACT(MONTH FROM date_transaction) = ? ', mes_actual).where('type_transaction = ? ', @ingreso).where(user_id: current_user.id).sum(:mount)

    # gastos, admin
    @gastos_mes_actual = Transaction.group_by_month(:date_transaction, format: "%m-%Y", time_zone: false).where('EXTRACT(MONTH FROM date_transaction) = ? ', mes_actual).where('type_transaction = ? ', @gasto).where(user_id: current_user.id).sum(:mount)

    # tipo gastos, admin
    @tipos_gastos_mes_actual = Transaction.joins(:tag).where('EXTRACT(MONTH FROM date_transaction) = ? ', mes_actual).where('type_transaction = ? ', @gasto).where(user_id: current_user.id).group(:name).sum(:mount)

    # ingresos Ult. 12 meses, admin
    @ingresos_ultimos_meses = Transaction.group_by_month(:date_transaction, format: "%m-%Y", time_zone: false).where('EXTRACT(MONTH FROM date_transaction) < ? ', 12.month).where(user_id: current_user.id).where('type_transaction = ? ', @ingreso).sum(:mount)

    # gastos Ult. 12 meses, admin
    @gastos_ultimos_meses = Transaction.group_by_month(:date_transaction, format: "%m-%Y", time_zone: false).where('EXTRACT(MONTH FROM date_transaction) < ? ', 12.month).where(user_id: current_user.id).where('type_transaction = ? ', @gasto).sum(:mount)

    if User.find(current_user.id).housings.count == 0
      redirect_to root_path
    else
      # gastos_compartidos mes actual, member
      @gastos_mes_actual_member = Transaction.group_by_month(:date_transaction, format: "%m-%Y", time_zone: false).where('EXTRACT(MONTH FROM date_transaction) = ? ', mes_actual).where('type_transaction = ? ', @gasto_compartido).where(housing_id: @housing.id).sum(:mount)

      # gastos_compartidos Ult 12 meses, member
      @gastos_ultimos_meses_member = Transaction.group_by_month(:date_transaction, format: "%m-%Y", time_zone: false).where('EXTRACT(MONTH FROM date_transaction) < ? ', 12.month).where(housing_id: @housing.id).where('type_transaction = ? ', @gasto_compartido).sum(:mount)
    end

    respond_to do |format|
      format.html
      sleep 10
      format.pdf {
        render pdf: 'reporte', # nombre del archivo a generar
        template: 'dashboard/index.html.erb', # plantilla a renderizar
        layout: 'pdf.html',
        orientation: "Landscape",
        page_size: "A4",
        encoding: "UTF-8"
        # disposition: "attachment" # descargar
      }
    end

  end

  def type_transactions
    types = Transaction.type_transactions.to_a
    @ingreso = types[0][1].to_i
    @gasto =  types[1][1].to_i
    @gasto_compartido =  types[2][1].to_i
  end

  def transactions_current_user_admin
    unless User.find(current_user.id).housings.count == 0
      current_housing_admin = HousingUser.find_by(user_id: current_user.id).housing_id
      Housing.find(current_housing_admin)
    end
  end

end
