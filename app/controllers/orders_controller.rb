class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy approve ]

  # GET /orders or /orders.json
  def index
    @orders = current_user.orders
  end

  def sales
    @orders = current_user.orders.where(order_status: "requested")
    render 'index'
  end

  # GET /orders/1 or /orders/1.json
  def show
    @certificates = @order.certificates

  end

  # GET /orders/new
  def new
    @order = current_user.orders.build
  end

  # GET /orders/1/edit
  def edit

  end

  # POST /orders or /orders.json
  def create
    @order = current_user.orders.build(order_params)
    @order.advance_status
    respond_to do |format|
      if @order.save
        format.html { redirect_to order_url(@order), notice: "Order was successfully created." }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def approve
    @order = current_user.orders.find(params[:id])
    @order.advance_status
    @order.save
  end



  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    @order.advance_status

    respond_to do |format|
      if @order.save
        format.html { redirect_to order_url(@order), notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = current_user.orders.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:name, :description, :order_status, :user_id, :certificate_id)
    end
end
