require 'khipu-api-client'
class PollasController < ApplicationController
  before_action :set_polla, only: [:show, :edit, :update, :destroy, :validar_polla, :invalidar_polla, :crear_pago_polla]
  before_action :validar_pagos, only: [:index]
  before_action :verify_user
  before_action :verify_mod, only: [:pollas_totales]
  def index
    @pollas = Polla.where(:user_id => current_user.id)
  end

  def pollas_totales
    if current_user && (current_user.is_admin || current_user.is_mod || current_user.id == 2)
      @pollas = Polla.all
    else
      redirect_to root_path
    end
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

  def validar_polla
    @polla.valid_polla = 1
    @polla.save
    redirect_to pollas_path
  end

  def invalidar_polla
    @polla.valid_polla = 0
    @polla.save
    redirect_to pollas_path
  end

  def crear_pago_polla#recibe polla y current_user
    if Time.now > Time.zone.parse('2019-06-14 15:30:00')
      redirect_to root_path
    else
      receiver_id = ENV['RECEIVER_ID']
      secret_key = ENV['RECEIVER_SECRET']

      Khipu.configure do |c|
        c.secret = secret_key
        c.receiver_id = receiver_id
        c.platform = 'demo-client'
        c.platform_version = '2.0'
        # c.debugging = true
      end

      api = Khipu::PaymentsApi.new()
      @transaction = current_user.transactions.create()
      amount = 2000
      response = api.payments_post('Pago polla' + @polla.name, 'CLP', amount, { #CAMBIAR A 1000
          transaction_id: @transaction.id,
          expires_date: DateTime.new(2019, 6, 14),
          send_email: true,
          payer_name: current_user.name,
          payer_email: current_user.email,
          return_url: 'localhost:3000/pollas',
          cancel_url: 'localhost:3000',
          #notify_url: 'http://mi-ecomerce.com/backend/notify',
          notify_api_version: '1.3'
      })
      puts 'response: '
      puts response 
      @polla.paying = 1
      @transaction.payment_id = response.payment_id
      @transaction.amount = amount
      @transaction.polla_id = @polla.id
      @transaction.payment_url = response.payment_url
      @transaction.charged = 0
      #@transaction.transfer_url = response.transfer_url
      #@transaction.app_url = response.app_url
      @polla.save
      @transaction.save
      redirect_to response.payment_url
    end
  end

  # POST /pollas
  # POST /pollas.json
  def create
    @polla = current_user.pollas.create(polla_params)
    @polla.valid_polla = 0
    @polla.score = 0
    @polla.paying = 0
    @polla.name = params['pollaName']
    first_round_a = params['first_round_a'].split(",")
    first_round_b = params['first_round_b'].split(",")
    first_round_c = params['first_round_c'].split(",")


    (0..first_round_a.length-1).each do |n|
      @first_round = FirstRound.new
      @first_round.polla_id = @polla.id
      @first_round.group = 'a'
      @first_round.country_name = first_round_a[n]
      @first_round.position = n + 1
      @first_round.save!
    end

    (0..first_round_b.length-1).each do |n|
      @first_round = FirstRound.new
      @first_round.polla_id = @polla.id
      @first_round.group = 'b'
      @first_round.country_name = first_round_b[n]
      @first_round.position = n + 1
      @first_round.save!
    end 
    
    (0..first_round_c.length-1).each do |n|
      @first_round = FirstRound.new
      @first_round.polla_id = @polla.id
      @first_round.group = 'c'
      @first_round.country_name = first_round_c[n]
      @first_round.position = n + 1
      @first_round.save!
    end 

    quarter_final = params['quarter_final'].split(",")
    semifinal = params['semifinal'].split(",")
    third_place = params['third_place'].split(",")
    final = params['final'].split(",")

    (0..quarter_final.length-1).step(5).each do |n|
      @bet = Bet.new
      @bet.polla_id = @polla.id
      @bet.country_1_name = quarter_final[n]
      @bet.country_2_name = quarter_final[n+1]
      @bet.result_team_1 = quarter_final[n+2]
      @bet.result_team_2 = quarter_final[n+3]
      @bet.result = quarter_final[n+4]
      @bet.stage = 'quarter'
      @bet.save
    end

    (0..semifinal.length-1).step(5).each do |n|
      @bet = Bet.new
      @bet.polla_id = @polla.id
      @bet.country_1_name = semifinal[n]
      @bet.country_2_name = semifinal[n+1]
      @bet.result_team_1 = semifinal[n+2]
      @bet.result_team_2 = semifinal[n+3]
      @bet.result = semifinal[n+4]
      @bet.stage = 'semis'
      @bet.save
    end

    (0..third_place.length-1).step(5).each do |n|
      @bet = Bet.new
      @bet.polla_id = @polla.id
      @bet.country_1_name = third_place[n]
      @bet.country_2_name = third_place[n+1]
      @bet.result_team_1 = third_place[n+2]
      @bet.result_team_2 = third_place[n+3]
      @bet.result = third_place[n+4]
      @bet.stage = 'third_place'
      @bet.save
    end

    (0..final.length-1).step(5).each do |n|
      @bet = Bet.new
      @bet.polla_id = @polla.id
      @bet.country_1_name = final[n]
      @bet.country_2_name = final[n+1]
      @bet.result_team_1 = final[n+2]
      @bet.result_team_2 = final[n+3]
      @bet.result = params['final'][n+4]
      @bet.stage = 'final'
      @bet.save
    end

    respond_to do |format|
      if @polla.save
        format.html { redirect_to pollas_path}
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
        format.html { redirect_to pollas_path}
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
      format.html { redirect_to pollas_path}
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

    def validar_pagos
      @transactions = Transaction.where(:charged => 0)
      if @transactions
        receiver_id = ENV['RECEIVER_ID']
        secret_key = ENV['RECEIVER_SECRET']
  
        Khipu.configure do |c|
          c.secret = secret_key
          c.receiver_id = receiver_id
          c.platform = 'demo-client'
          c.platform_version = '2.0'
          # c.debugging = true
        end
  
        api    = Khipu::PaymentsApi.new()
        @transactions.each do |trans|
            cosas = trans.payment_url.split("/")
            status = api.payments_id_get(cosas[-1])
            @polla =  Polla.find(trans.polla_id)
            if status.status == 'done'
              @polla.valid_polla = 1
              trans.charged = 1
              trans.save
              @polla.save
            end
        end
      end
      #redirect_to pollas_path
    end

    def verify_mod
      if !current_user || !current_user.is_mod || !current_user.is_admin
        redirect_to root_path
      end
    end

    def verify_user
      if !current_user
        flash[:danger] = "¡Debes iniciar sesión para acceder ahí!"
        redirect_to login_path
      end
    end
end
