class ThingsController < ApplicationController
  before_filter :authenticate_user!
  # GET /things
  # GET /things.json
  def index
    @things = current_user.owned_things.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @things }
    end
  end


  # GET /things/lent
  def lent
    # This isn't perfect.  @things is set to Things where 
    # the current user has a stake, but isn't the current holder of the Thing.
    #
    # Other Users may also have a stake in an item, and be holding it, 
    # and it's not technically a loan, but it may be of interest when loading this route.

    # TODO: group these by User
    @things = current_user.owned_things.where("held_by != #{current_user.id}")

    respond_to do |format|
      format.html # lent.html.erb
      format.json { render json: @things }
    end
  end

  # GET /things/borrowed
  def borrowed
    @things = Thing.borrowed(current_user)

    respond_to do |format|
      format.html # borrowed.html.erb
      format.json { render json: @things }
    end
  end

  # GET /things/available
  def available
    @things = Thing.available(current_user)

    respond_to do |format|
      format.html # available.html.erb
      format.json { render json: @things }
    end
  end

  # GET /things/1
  # GET /things/1.json
  def show
    @thing = Thing.viewable(current_user).find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @thing }
    end
  end

  # GET /things/new
  # GET /things/new.json
  def new
    @thing = Thing.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @thing }
    end
  end

  # GET /things/1/edit
  def edit
    @thing = current_user.owned_things.find(params[:id])
  end

  # POST /things
  # POST /things.json
  def create
    #@thing = Thing.new(params[:thing])
    @thing = current_user.things.build(params[:thing])
    @thing.holder = current_user

    respond_to do |format|
      if @thing.save
        @stake = current_user.stakes.build(
          :amount => 1
        )
        @stake.thing = @thing
        if(@stake.save)
          format.html { redirect_to @thing, notice: 'Thing was successfully created.' }
          format.json { render json: @thing, status: :created, location: @thing }
        else
          format.html { render action: "new" }
          format.json { render json: @thing.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PUT /things/1
  # PUT /things/1.json
  def update
    @thing = current_user.owned_things.find(params[:id])

    respond_to do |format|
      if @thing.update_attributes(params[:thing])
        format.html { redirect_to @thing, notice: 'Thing was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @thing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /things/1
  # DELETE /things/1.json
  def destroy
    @thing = current_user.things.find(params[:id])
    @thing.destroy

    respond_to do |format|
      format.html { redirect_to things_url }
      format.json { head :no_content }
    end
  end
end
