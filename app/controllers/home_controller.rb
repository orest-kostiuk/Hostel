# frozen_string_literal: true

class HomeController < ApplicationController

  def index
    @users = User.all
  end

  def delete_image_attachment
    current_user.image = ActiveStorage::Blob.find_signed(params[:id])
    current_user.image.purge
    redirect_to edit_user_registration_url
  end
end
