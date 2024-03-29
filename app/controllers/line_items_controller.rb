class LineItemsController < ApplicationController
  skip_before_action :authorize, only: :create

  include CurrentCart

  before_action :set_cart, only: [:create, :destroy]
  before_action :set_line_item, only: %i[ show edit update destroy ]
  after_action :reset_counter, only: [:create]

  # GET /line_items or /line_items.json
  def index
    @line_items = LineItem.all
  end

  # GET /line_items/1 or /line_items/1.json
  def show
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items or /line_items.json
  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product)

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to store_index_url }
        format.js { @current_item = @line_item }
        format.json { render :show, status: :created, location: @line_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_items/1 or /line_items/1.json
  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to line_item_url(@line_item), notice: "Line item was successfully updated." }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1 or /line_items/1.json
  def destroy
    @line_item.destroy

    respond_to do |format|
      format.html { redirect_to cart_path(session[:cart_id]), notice: "Line item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def decrement
    @line_item = LineItem.find(params[:id])
    # byebug
    if @line_item && @line_item.quantity > 1 && session[:cart_id]
      respond_to do |format|
        if @line_item.decrement!(:quantity)
          format.html { redirect_to store_index_url, notice: "Line item was successfully updated." }
          format.json { head :no_content, status: :ok, location: @line_item }
        else
          format.html { redirect_to cart_path(session[:cart_id]), status: :unprocessable_entity }
          format.json { render json: @line_item.errors, status: :unprocessable_entity }
        end
      end
    else
      @line_item.destroy

      respond_to do |format|
        format.html { redirect_to cart_path(session[:cart_id]), notice: "Line item was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def line_item_params
      params.require(:line_item).permit(:product_id)
    end

    def reset_counter
      session[:counter] = 0 unless session[:counter].nil?
    end
end
