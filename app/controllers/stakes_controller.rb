class StakesController < ApplicationController
  before_filter :authenticate_user!

  # GET /stakes
  # GET /stakes.json
  def index
    @stakes = current_user.stakes.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stakes }
    end
  end

  # GET /stakes/1
  # GET /stakes/1.json
  def show
    @stake = Stake.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stake }
    end
  end

  # GET /stakes/new
  # GET /stakes/new.json
  def new
    @stake = Stake.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stake }
    end
  end

  # GET /stakes/1/edit
  def edit
    @stake = Stake.find(params[:id])
  end

  # POST /stakes
  # POST /stakes.json
  def create
    @stake = Stake.new(params[:stake])

    respond_to do |format|
      if @stake.save
        format.html { redirect_to @stake, notice: 'Stake was successfully created.' }
        format.json { render json: @stake, status: :created, location: @stake }
      else
        format.html { render action: "new" }
        format.json { render json: @stake.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stakes/1
  # PUT /stakes/1.json
  def update
    @stake = Stake.find(params[:id])

    respond_to do |format|
      if @stake.update_attributes(params[:stake])
        format.html { redirect_to @stake, notice: 'Stake was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stake.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stakes/1
  # DELETE /stakes/1.json
  def destroy
    @stake = Stake.find(params[:id])
    @stake.destroy

    respond_to do |format|
      format.html { redirect_to stakes_url }
      format.json { head :no_content }
    end
  end
end
