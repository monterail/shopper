class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :set_product, only: [:new, :create]

  # GET /orders
  # GET /orders.json
  def index
    @orders = current_user.orders
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new(product: @product)
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @order.product = @product
    @order.user = current_user

    current_discounts = SpecialOffer.where("date_from < ? AND date_to > ?", DateTime.now, DateTime.now)
    total_discount = current_discounts.map(&:discount).reduce(0, :+)
    total_price_before_discount = @order.quantity * @product.price
    total_price_after_discount = total_price_before_discount - (total_price_before_discount * total_discount / 100)
    @order.total_price = total_price_after_discount

    respond_to do |format|
      if @order.save
        @product.update(quantity_in_stock: @product.quantity_in_stock - order_params[:quantity].to_i)
        OrderMailer.shop_owner_order_notification(@order).deliver!
        SendOrderPaymentNotificationWorker.perform_in(24.hours, @order)

        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        puts "Error log: Order could not be created. Errors: #{@order.errors}"

        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    def set_product
      @product = Product.find(params[:product_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:quantity)
    end
end
