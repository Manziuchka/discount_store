class  Api::DiscountController < ActionController::API
  before_action :find_discount, except: %i[create index]

  # GET /product_discount
  def index
    @product_discount = PriceRule.all
    render json: @product_discount, status: :ok
  end

  # GET /product_discount/{product_code}
  def show
    render json: @product_discount, status: :ok
  end

  # POST /product_discount/
  def create
    @product_discount = PriceRule.new(discount_params)
    if @product_discount.save
      render json: @product_discount, status: :created
    else
      render json: { errors: @product_discount.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /product/
  def update
    unless @product_discount.update(discount_params)
      render json: { errors: @product_discount.errors.full_messages },
            status: :unprocessable_entity
    end
  end

  # DELETE /price_rule/{product_code}
  def destroy
    @product_discount.destroy
  end

  private
  def find_discount
    @product_discount = PriceRule.find_by_product_code(params[:product_code])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'product discount not found' }, status: :not_found
  end

  def discount_params
    params.permit(
      :product_code, :discount_code, :percentage, :min_amount
    )
  end
end