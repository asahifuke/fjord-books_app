# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def after_sign_in_path_for(*)
    books_path
  end

  def after_sign_out_path_for(*)
    new_user_session_path
  end
end
