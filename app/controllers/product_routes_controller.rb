class ProductRoutesController < ApplicationController
  # GET /product_routes
  def index
  end

  # POST /product_routes/search
  # GET /product_routes/search
  def search
    reference = params[:reference]&.strip
    if reference.blank?
      flash[:error] = "Please enter the product's reference"
      redirect_to(action: :index) && return
    end
    product = Product.find_by(reference: reference)
    if product
      @product_route = ProductRouteService.new(reference)
    else
      flash.now[:error] = "Product with reference (\"#{reference}\") not found"
    end
    render :index
  end
end
