class HomeController < ApplicationController
  before_action :active_nav
  def active_nav
    @active = "home"
  end
  def show
    @pollas = Polla.where(:valid_polla => 1)
    @pozo = [30000, @pollas.length*200].max #corregir
  end
  def ranking
    @pollas = Polla.where(:valid_polla => 1).order(:score).limit(10)
  end
end
