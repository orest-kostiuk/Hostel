# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @posts = Post.all.where(is_published: true)
  end
end
