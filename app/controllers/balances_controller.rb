# frozen_string_literal: true

class BalancesController < ApplicationController
  def show
    @balance = current_user.tenant&.balance
  end
end
