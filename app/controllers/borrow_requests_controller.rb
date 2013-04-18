class BorrowRequestsController < ApplicationController
  before_filter :authenticate_user!
  # GET /borrow_requests
  # GET /borrow_requests.json
  def index
    @borrow_requests = current_user.borrow_requests.all
    @pending_approvals = current_user.approvals.where("status = 'pending'")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @borrow_requests }
    end
  end

  # GET /borrow_requests/1
  # GET /borrow_requests/1.json
  def show
    @borrow_request = BorrowRequest.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @borrow_request }
    end
  end

  # GET /borrow_requests/new
  # GET /borrow_requests/new.json
  def new
    @borrow_request = BorrowRequest.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @borrow_request }
    end
  end

  # GET /borrow_requests/1/edit
  def edit
    @borrow_request = BorrowRequest.find(params[:id])
  end

  # POST /borrow_requests
  # POST /borrow_requests.json
  def create
    @borrow_request = BorrowRequest.new(params[:borrow_request])

    respond_to do |format|
      if @borrow_request.save
        format.html { redirect_to @borrow_request, notice: 'Borrow request was successfully created.' }
        format.json { render json: @borrow_request, status: :created, location: @borrow_request }
      else
        format.html { render action: "new" }
        format.json { render json: @borrow_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /borrow_requests/1
  # PUT /borrow_requests/1.json
  def update
    @borrow_request = BorrowRequest.find(params[:id])

    respond_to do |format|
      if @borrow_request.update_attributes(params[:borrow_request])
        format.html { redirect_to @borrow_request, notice: 'Borrow request was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @borrow_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /borrow_requests/1
  # DELETE /borrow_requests/1.json
  def destroy
    @borrow_request = BorrowRequest.find(params[:id])
    @borrow_request.destroy

    respond_to do |format|
      format.html { redirect_to borrow_requests_url }
      format.json { head :no_content }
    end
  end
end
