require 'khipu-api-client'
class PollasController < ApplicationController
  before_action :set_polla, only: [:show, :edit, :update, :destroy]

  def index
    @pollas = Polla.where(:user_id => current_user.id)
  end

  # GET /pollas/1
  # GET /pollas/1.json
  def show
    @pollas = Polla.where(:user_id => current_user.id)
  end

  # GET /pollas/new
  def new
    @polla = Polla.new
    #@variable = polla_params["partidos"]["apuestas"]
    #@variable_2 = polla_params["partidos"]["apuestas"]
  end

  # GET /pollas/1/edit
  def edit
  end

  def validar_polla(polla)
    polla.valid = 1
  end

  def invalidar_polla(polla)
    polla.valid = 0
  end


  # POST /pollas
  # POST /pollas.json
  def create
    @polla = current_user.pollas.create(polla_params)
    @polla.valid_polla = 0
    @polla.score = 0

    (0..params["partidos"]["apuestas"].length-1).step(2) do |n|
      @bet = Bet.new
      @bet.polla_id = @polla.id
      @bet.result_team_1 = params["partidos"]["apuestas"][n]
      @bet.result_team_2 = params["partidos"]["apuestas"][n+1]
      @bet.match_id = n/2 +1
      @bet.save!

    end

    respond_to do |format|
      if @polla.save
        format.html { redirect_to @polla, notice: 'polla was successfully created.' }
        format.json { render :show, status: :created, location: @polla }
      else
        format.html { render :new }
        format.json { render json: @polla.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pollas/1
  # PATCH/PUT /pollas/1.json
  def update
    respond_to do |format|
      if @polla.update(polla_params)
        format.html { redirect_to @polla, notice: 'polla was successfully updated.' }
        format.json { render :show, status: :ok, location: @polla }
      else
        format.html { render :edit }
        format.json { render json: @polla.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pollas/1
  # DELETE /pollas/1.json
  def destroy
    @polla.destroy
    respond_to do |format|
      format.html { redirect_to pollas_url, notice: 'polla was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_polla
      @polla = Polla.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def polla_params
      params.permit(:name, :partidos)
    end
end
