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
    respond_to do |format|
      @result.save
      if @result.stage == 'groups'
        @bets =  FirstRound.where("polla.valid_polla = ? AND group = ?", 1, params['group'])
        @bets.each do |bet|
          if params['team_1'] == bet.country_name && bet.position == params['position']
            bet.polla.score += 10
          end
        end
      else
        @bets =  Bet.where("polla.valid_polla = ? AND stage = ?", 1, params['stage'])
        @bets.each do |bet|
          if params['team_1'] == bet.country_1_name && params['team_2'] == bet.country_2_name
            if params['result_team_1'] == bet.result_team_1 && params['result_team_2'] == bet.result_team_2
              bet.polla.score += 5 
            elsif params['result_team_1'] > params['result_team_2'] && bet.result_team_1 > bet.result_team_2
              bet.polla.score += 2
            elsif params['result_team_1'] < params['result_team_2'] && bet.result_team_1 < bet.result_team_2
              bet.polla.score += 2
            end 
          elsif params['team_2'] == bet.country_2_name && params['team_1'] == bet.country_1_name
            if params['result_team_2'] == bet.result_team_2 && params['result_team_1'] == bet.result_team_1
              bet.polla.score += 5 
            elsif params['result_team_2'] > params['result_team_1'] && bet.result_team_2 > bet.result_team_1
              bet.polla.score += 2
            elsif params['result_team_2'] < params['result_team_1'] && bet.result_team_2 < bet.result_team_1
              bet.polla.score += 2
            end 
          end
        end
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
    @result.destroy
    respond_to do |format|
      format.html { redirect_to results_url, notice: 'Result was successfully destroyed.' }
      format.json { head :no_content }
    end
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
