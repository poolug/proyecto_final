class ApplicationController < ActionController::Base
  # se usa este callback, si es que está instalado el controlador de devise
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # permite agregar parámeetros adicionales al modelo User, el cual tiene instalado devise
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :avatar])
  end
end
