require 'khipu-api-client'
class PollasController < ApplicationController
  before_action :set_polla, only: [:show, :edit, :update, :destroy, :validar_polla, :invalidar_polla, :crear_pago_polla]

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
    if Time.now > Time.zone.parse('2019-06-14 11:00:00')
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
          return_url: pollas_path,
          cancel_url: root_path,
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
      format.html { redirect_to root_path}
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
