class FirstRoundsController < ApplicationController
  before_action :set_first_round, only: [:show, :edit, :update, :destroy]

  # GET /first_rounds
  # GET /first_rounds.json
  def index
    @first_rounds = FirstRound.all
  end

  # GET /first_rounds/1
  # GET /first_rounds/1.json
  def show
  end

  # GET /first_rounds/new
  def new
    @first_round = FirstRound.new
  end

  # GET /first_rounds/1/edit
  def edit
  end

  # POST /first_rounds
  # POST /first_rounds.json
  def create
    @first_round = FirstRound.new(first_round_params)

    respond_to do |format|
      if @first_round.save
        format.html { redirect_to @first_round, notice: 'First round was successfully created.' }
        format.json { render :show, status: :created, location: @first_round }
      else
        format.html { render :new }
        format.json { render json: @first_round.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /first_rounds/1
  # PATCH/PUT /first_rounds/1.json
  def update
    respond_to do |format|
      if @first_round.update(first_round_params)
        format.html { redirect_to @first_round, notice: 'First round was successfully updated.' }
        format.json { render :show, status: :ok, location: @first_round }
      else
        format.html { render :edit }
        format.json { render json: @first_round.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /first_rounds/1
  # DELETE /first_rounds/1.json
  def destroy
    @first_round.destroy
    respond_to do |format|
      format.html { redirect_to first_rounds_url, notice: 'First round was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_first_round
      @first_round = FirstRound.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def first_round_params
      params.require(:first_round).permit(:country_name, :position, :group)
    end
end
