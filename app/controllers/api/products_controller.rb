class  Api::ProductsController < ActionController::API
  before_action :find_product, except: %i[create index]

  # GET /products
  def index
    @product = Price.all
    render json: @product, status: :ok
  end

  # GET /product/{product_code}
  def show
    render json: @product, status: :ok
  end

  # POST /product/
  def create
    @product = Price.new(product_params)
    if @product.save
      render json: @product, status: :created
    else
      render json: { errors: @product.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /product/
  def update
    unless @product.update(product_params)
      render json: { errors: @product.errors.full_messages },
            status: :unprocessable_entity
    end
  end

  # DELETE /products/{product_code}
  def destroy
    @product.destroy
  end

  # GET /products/check_please
  def checkout
    @pricing_rules = PriceRule.all
    co = Checkout.new(@pricing_rules)
    @input = product_params[:input]
    for i in 0..(@input.size+1/3)
      unless @input[i*3] == @null
        co.add( Price.find_by_product_code( @input[i*3]+@input[i*3+1] ) )
      end
    end

    render json: co.total, status: :ok
  end

  private
  def find_product
    @product = Price.find_by_product_code(params[:product_code])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'product not found' }, status: :not_found
  end

  def product_params
    params.permit(
      :product_code, :name, :cost, :input
    )
  end
end
