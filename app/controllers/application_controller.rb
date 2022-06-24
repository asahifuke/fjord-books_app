# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(*)
    books_path
  end

  def after_sign_out_path_for(*)
    new_user_session_path
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: %i[zip_code address introduction])
  end
end
