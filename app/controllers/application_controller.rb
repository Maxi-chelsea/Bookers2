class ApplicationController < ActionController::Base
  before_action :authenticate_user!,except: [:top, :about]
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def show
    @book = Book.find(params[:id])
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :name])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  end

  def after_sign_in_path_for(resource)
    user_path(current_user)
  end


  def after_sign_out_path_for(resource)
    root_path
  end


end
