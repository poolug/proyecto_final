class ApplicationController < ActionController::Base
  # se usa este callback, si es que está instalado el controlador de devise
  before_action :configure_permitted_parameters, if: :devise_controller?

  def only_super_user!
    unless current_user.email?
      flash[:alert]= 'No tienes permisos suficientes para realizar esta acción'
      redirect_to root_path
    end
  end

  protected

  # permite agregar parámeetros adicionales al modelo User, el cual tiene instalado devise
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
