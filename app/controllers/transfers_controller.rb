class TransfersController < ApplicationController
  before_filter :authenticate_user!
  # GET /transfers
  # GET /transfers.json
  def index
    @transfers = Transfer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @transfers }
    end
  end

  # GET /transfers/1
  # GET /transfers/1.json
  def show
    @transfer = Transfer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @transfer }
    end
  end

  # GET /transfers/new
  # GET /transfers/new.json
  def new
    @transfer = Transfer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @transfer }
    end
  end

  # GET /transfers/1/edit
  def edit
    @transfer = Transfer.find(params[:id])
  end

  # POST /transfers
  # POST /transfers.json
  def create
    borrow_request = BorrowRequest.find(params[:transfer][:borrow_request_id])
    if(borrow_request)
      # Everything about a new transfer can be inferred from the borrow_request
      @transfer = borrow_request.build_transfer()
    else
      @transfer = Transfer.new()
      @transfer.datetime = User.find(params[:transfer][:datetime])
      @transfer.giver = User.find(params[:transfer][:giver])
      @transfer.receiver = User.find(params[:transfer][:receiver])
      @transfer.thing = Thing.find(params[:transfer][:thing])
    end

    thing = @transfer.thing
    thing.holder = @transfer.receiver

    success = false
    ActiveRecord::Base.transaction do
      success = @transfer.save && thing.save
    end

    respond_to do |format|
      if success
        format.html { redirect_to @transfer.thing, notice: 'Transfer was successfully logged.' }
        format.json { render json: @transfer, status: :created, location: @transfer }
      else
        format.html { render action: "new" }
        format.json { render json: @transfer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /transfers/1
  # PUT /transfers/1.json
  def update
    @transfer = Transfer.find(params[:id])

    respond_to do |format|
      if @transfer.update_attributes(params[:transfer])
        format.html { redirect_to @transfer, notice: 'Transfer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @transfer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transfers/1
  # DELETE /transfers/1.json
  def destroy
    @transfer = Transfer.find(params[:id])
    @transfer.destroy

    respond_to do |format|
      format.html { redirect_to transfers_url }
      format.json { head :no_content }
    end
  end
end
