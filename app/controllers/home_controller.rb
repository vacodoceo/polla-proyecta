class HomeController < ApplicationController
  before_action :active_nav
  def active_nav
    @active = "home"
  end
  def show
  end
end
