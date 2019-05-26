require 'khipu-api-client'
class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy, :revisar_estado_pago]

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
      api    = Khipu::PaymentsApi.new()

      @transactions.each do |trans|
        status = api.payments_id_get(trans.payment_id)
        @polla =  trans.polla
        if status == 'done'
          @polla.valid_polla = 1
        end
        trans.charged = 1
        trans.save
        @polla.save
      end
    end
    redirect_to root_path
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
  
  def revisar_estado_pago #RECIBE LA transaccion
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
    @polla =  @transaction.polla
    if status == 'done'
      @polla.valid_polla = 1
    end
    @transaction.charged = 1
    @transaction.save
    @polla.save
    puts 'status:' + status
  end
  
 # def confirmar_pago(polla, transaction) #recibe la polla y la transaccion
  #  receiver_id = ENV['RECEIVER_ID']
   # secret_key = ENV['RECEIVER_SECRET']

    #Khipu.configure do |c|
     # c.secret = secret_key
      #c.receiver_id = receiver_id
      #c.platform = 'demo-client'
      #c.platform_version = '2.0'
      # c.debugging = true
   # end
    #notification_token = transaction.notification_token  # Parámetro notification_token
    #amount = 1
    #client = Khipu::PaymentsApi.new()
    #response = client.payments_get(notification_token)
    #if response.status == 'done'
     # polla.valid_polla = 1
    #end
 # end

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
