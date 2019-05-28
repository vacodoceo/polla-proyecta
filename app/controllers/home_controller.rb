class HomeController < ApplicationController
  def show
    @acitve = "home"
    @pollas = Polla.where(:valid_polla => 1)
    @pozo = [30000, @pollas.length*200].max #corregir
  end
  def ranking
    @active = "ranking"
    @pollas = Polla.where(:valid_polla => 1).order(:score).limit(10)
  end
end
