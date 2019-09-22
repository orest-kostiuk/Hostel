# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[login_code email password password_confirmation])
    devise_parameter_sanitizer.permit(:sign_in, keys: %i[login password password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[login_code email password password_confirmation
                                                                current_password first_name surname last_name index
                                                                region district city street house_number
                                                                passport_series who_issued_the_passport
                                                                when_issued_the_passport the_taxpayer_identification_number
                                                                phone_number])
  end
end
