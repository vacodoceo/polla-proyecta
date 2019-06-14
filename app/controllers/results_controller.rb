class ResultsController < ApplicationController
  before_action :set_result, only: [:show, :edit, :update, :destroy]
  before_action :verify_mod

  # GET /results
  # GET /results.json
  def index
    @results = Result.all
  end

  # GET /results/1
  # GET /results/1.json
  def show
  end

  # GET /results/new
  def new
    @result = Result.new
  end

  # GET /results/1/edit
  def edit
  end

  # POST /results
  # POST /results.json
  def create
    @result = Result.new(result_params)
    @result.save
    if @result.stage == 'groups'
      @apuestas =  FirstRound.where(:group => params['group'])
      @bets = []
      @apuestas.each do |ap|
        if ap.polla.valid_polla == 1
          @bets << ap
        end
      end
      @bets.each do |bet|
        if params['team_1'] == bet.country_name && bet.position == @result.position
          bet.polla.score += 5
          bet.polla.save
        end
      end
    elsif @result.stage == 'quarter'
      @apuestas =  Bet.where(:stage => params['stage'])
      @bets = []
      n = params["n"].to_i
      i = 0
      @apuestas.each do |ap|
        if n == i && ap.polla.valid_polla == 1
          @bets << ap
        end
        if i == 3
          i = 0
        else
          i+=1
        end
      end
      @bets.each do |bet|
        if (params['team_1'] == bet.country_1_name && params['team_2'] == bet.country_2_name)
          if (@result.result_team_1 > @result.result_team_2 && bet.result_team_1 > bet.result_team_2) || (@result.result_team_1 < @result.result_team_2 && bet.result_team_1 < bet.result_team_2) || (@result.result_team_1 == @result.result_team_2 && bet.result_team_1 == bet.result_team_2)
            bet.polla.score += 5 
            if (@result.result_team_1  - @result.result_team_2 == bet.result_team_1 - bet.result_team_2) || (@result.result_team_2 - @result.result_team_1 == bet.result_team_2 - bet.result_team_1)
              bet.polla.score += 1
            end 
          end
          if @result.result_team_1 == bet.result_team_1 
            bet.polla.score += 2
          end 
          if @result.result_team_2 == bet.result_team_2
            bet.polla.score += 2
          end 
        elsif params['team_2'] == bet.country_1_name && params['team_1'] == bet.country_2_name
          if (@result.result_team_1 > @result.result_team_2 && bet.result_team_1 < bet.result_team_2) || (@result.result_team_1 < @result.result_team_2 && bet.result_team_1 > bet.result_team_2) || (@result.result_team_1 == @result.result_team_2 && bet.result_team_1 == bet.result_team_2)
            bet.polla.score += 5 
            if (@result.result_team_1 - @result.result_team_2 == bet.result_team_2 - bet.result_team_1) || (@result.result_team_2 - @result.result_team_1 == bet.result_team_1 - bet.result_team_2)
              bet.polla.score += 1
            end 
          end
          if @result.result_team_1 == bet.result_team_2 
            bet.polla.score += 2
          end 
          if @result.result_team_2 == bet.result_team_1
            bet.polla.score += 2
          end 
        end
        bet.polla.save
      end
    else
      @apuestas =  Bet.where(:stage => params['stage'])
      @bets = []
      @apuestas.each do |ap|
        if ap.polla.valid_polla == 1
          @bets << ap
        end
      end
      @bets.each do |bet|
        if (params['team_1'] == bet.country_1_name && params['team_2'] == bet.country_2_name)
          if (@result.result_team_1 > @result.result_team_2 && bet.result_team_1 > bet.result_team_2) || (@result.result_team_1 < @result.result_team_2 && bet.result_team_1 < bet.result_team_2) || (@result.result_team_1 == @result.result_team_2 && bet.result_team_1 == bet.result_team_2)
            bet.polla.score += 5 
            if (@result.result_team_1  - @result.result_team_2 == bet.result_team_1 - bet.result_team_2) || (@result.result_team_2 - @result.result_team_1 == bet.result_team_2 - bet.result_team_1)
              bet.polla.score += 1
            end 
          end
          if @result.result_team_1 == bet.result_team_1 
            bet.polla.score += 2
          end 
          if @result.result_team_2 == bet.result_team_2
            bet.polla.score += 2
          end 
        elsif params['team_2'] == bet.country_1_name && params['team_1'] == bet.country_2_name
          if (@result.result_team_1 > @result.result_team_2 && bet.result_team_1 < bet.result_team_2) || (@result.result_team_1 < @result.result_team_2 && bet.result_team_1 > bet.result_team_2) || (@result.result_team_1 == @result.result_team_2 && bet.result_team_1 == bet.result_team_2)
            bet.polla.score += 5 
            if (@result.result_team_1 - @result.result_team_2 == bet.result_team_2 - bet.result_team_1) || (@result.result_team_2 - @result.result_team_1 == bet.result_team_1 - bet.result_team_2)
              bet.polla.score += 1
            end 
          end
          if @result.result_team_1 == bet.result_team_2 
            bet.polla.score += 2
          end 
          if @result.result_team_2 == bet.result_team_1
            bet.polla.score += 2
          end 
        end
        bet.polla.save
      end
    end
    redirect_to results_path, notice: 'Resultado agregado correctamente'
  end

  # PATCH/PUT /results/1
  # PATCH/PUT /results/1.json
  def update
    respond_to do |format|
      if @result.update(result_params)
        format.html { redirect_to results_path, notice: 'Result was successfully updated.' }
        format.json { render :show, status: :ok, location: @result }
      else
        format.html { render :edit }
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /results/1
  # DELETE /results/1.json
  def destroy
    if @result.stage == 'groups'
      @apuestas =  FirstRound.where(:group => @result.group)
      @bets = []
      @apuestas.each do |ap|
        if ap.polla.valid_polla == 1
          @bets << ap
        end
      end
      @bets.each do |bet|
        if @result.team_1 == bet.country_name && bet.position == @result.position
          bet.polla.score -= 5
          bet.polla.save
        end
      end
    else
      @apuestas =  Bet.where(:stage => @result.stage)
      @bets = []
      @apuestas.each do |ap|
        if ap.polla.valid_polla == 1
          @bets << ap
        end
      end
      @bets.each do |bet|
        if (@result.team_1 == bet.country_1_name && @result.team_2 == bet.country_2_name)
          if (@result.result_team_1 > @result.result_team_2 && bet.result_team_1 > bet.result_team_2) || (@result.result_team_1 < @result.result_team_2 && bet.result_team_1 < bet.result_team_2) || (@result.result_team_1 == @result.result_team_2 && bet.result_team_1 == bet.result_team_2)
            bet.polla.score -= 5 
            if (@result.result_team_1  - @result.result_team_2 == bet.result_team_1 - bet.result_team_2) || (@result.result_team_2 - @result.result_team_1 == bet.result_team_2 - bet.result_team_1)
              bet.polla.score -= 1
            end 
          end
          if @result.result_team_1 == bet.result_team_1 
            bet.polla.score -= 2
          end 
          if @result.result_team_2 == bet.result_team_2
            bet.polla.score -= 2
          end 
        elsif @result.team_2 == bet.country_1_name && @result.team_1 == bet.country_2_name
          if (@result.result_team_1 > @result.result_team_2 && bet.result_team_1 < bet.result_team_2) || (@result.result_team_1 < @result.result_team_2 && bet.result_team_1 > bet.result_team_2) || (@result.result_team_1 == @result.result_team_2 && bet.result_team_1 == bet.result_team_2)
            bet.polla.score -= 5 
            if (@result.result_team_1 - @result.result_team_2 == bet.result_team_2 - bet.result_team_1) || (@result.result_team_2 - @result.result_team_1 == bet.result_team_1 - bet.result_team_2)
              bet.polla.score -= 1
            end 
          end
          if @result.result_team_1 == bet.result_team_2 
            bet.polla.score -= 2
          end 
          if @result.result_team_2 == bet.result_team_1
            bet.polla.score -= 2
          end 
        end
        bet.polla.save
      end
    end
    @result.destroy
    redirect_to results_path
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_result
    @result = Result.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def result_params
    params.permit(:team_1, :team_2, :result_team_1, :result_team_2, :result, :stage, :position, :group)
  end

  def verify_mod
    if !current_user || !current_user.is_mod || !current_user.is_admin
      redirect_to root_path
    end
  end
end
