ActiveAdmin.register Housing do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    column :id
    column :name
    column :user_id
    column :created_at
    column :updated_at
    actions
  end
  
  show do |h|
    panel 'Housing' do
      table_for housing do |t|
        t.column :id
        t.column :name
        t.column :user_id
      end
    end

    # permite ver los usarios creadores de la vivienda
    panel 'Users' do
      table_for housing.users do |t|
        t.column :name
        t.column :email
      end
    end
  end

  permit_params :name
end