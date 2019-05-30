class HomeController < ApplicationController
  def show
    @active = "home"
  end
  def ranking
    @active = "ranking"
    @pollas = Polla.where(:valid_polla => 1).order(:score).limit(10)
  end
  def rules 
  end
  def faqs
  end
end
