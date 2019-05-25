require 'khipu-api-client'
class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]

  # GET /transactions
  # GET /transactions.json
  def index
    @transactions = Transaction.all
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url, notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def crear_pago_polla(polla, user) #recibe polla y current_user
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
    amount = 1
    response = api.payments_post('Pago polla' + polla.name, 'CLP', amount, { #CAMBIAR A 1000
        transaction_id: @transaction.id,
        expires_date: DateTime.new(2019, 6, 13),
        send_email: true,
        payer_name: user.name,
        payer_email: user.email,
        return_url: pollas_path,
        cancel_url: root_path,
        #notify_url: 'http://mi-ecomerce.com/backend/notify',
        notify_api_version: '1.3'
    })
    puts 'response: '+ response 
    polla.paying = 1
    @transaction.payment_id = response.payment_id
    @transaction.amount = amount
    @transaction.polla_id = polla.id
    @transaction.payment_url = response.payment_url
    #@transaction.transfer_url = response.transfer_url
    #@transaction.app_url = response.app_url
    @transaction.save
    redirect_to response.payment_url
  end
  
  def bancos_posibles
    receiver_id = ENV['RECEIVER_ID']
    secret_key = ENV['RECEIVER_SECRET']

    Khipu.configure do |c|
      c.secret = secret_key
      c.receiver_id = receiver_id
      c.platform = 'demo-client'
      c.platform_version = '2.0'
      # c.debugging = true
    end

    banks = Khipu::BanksApi.new()
    response_2 = banks.banks_get()
    puts 'bancos' + bancos
    return response_2
  end
  #-----------------------------------------------
  
  def revisar_estado_pago(transaction) #RECIBE LA transaccion
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
    status = api.payments_id_get(transaction.payment_id)
    if status == 'done'
      transaction.polla.valid = 1
    end
    puts 'status:' + status
  end
  
  def confirmar_pago(polla, transaction) #recibe la polla y la transaccion
    receiver_id = ENV['RECEIVER_ID']
    secret_key = ENV['RECEIVER_SECRET']

    Khipu.configure do |c|
      c.secret = secret_key
      c.receiver_id = receiver_id
      c.platform = 'demo-client'
      c.platform_version = '2.0'
      # c.debugging = true
    end
    notification_token = transaction.notification_token  # Parámetro notification_token
    amount = 1
    client = Khipu::PaymentsApi.new()
    response = client.payments_get(notification_token)
    if response.status == 'done'
      polla.valid = 1
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:transaction).permit(:content, :comment_id, :integer, :user_id, :integer)
    end
end
