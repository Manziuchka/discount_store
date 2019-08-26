class Checkout

  def initialize(_pricing_rules)
    @pricing_rules = _pricing_rules
    @items = []
  end

  def add(item)
   @items[items.size] = JSON.parse(item.to_json)
  end

  def total
    unless @items.empty?
      @items = @items.sort_by { |list| list['product_code'] }
      @check = []
      @check[0] = JSON.parse(@items[0].to_json)
      @check[0]['amount'] = 1
      @check[0] = add_discount_rules!(@check[check.size-1])
      for i in 1..items.size-1
        if items[i]['product_code'] == items[i-1]['product_code']
          @check[check.size-1]['amount'] = @check[check.size-1]['amount'] + 1
        else
          @check[check.size] = JSON.parse(@items[i].to_json)
          @check[check.size-1]['amount'] = 1
          @check[check.size-1] = add_discount_rules!(@check[check.size-1])
        end
      end

      @total = 0
      @check.each{|a| @total = @total + discount(a)}
      @total.round(2)
    else
      0
    end
  end

  private

  attr_accessor :items, :pricing_rules, :check

  def add_discount_rules!(product)
    @found = @pricing_rules.select{|rule| rule.product_code == product['product_code']}
    unless @found.empty?
      product['discount_code'] = @found[0]['discount_code']
      product['percentage'] = @found[0]['percentage']
      product['min_amount'] = @found[0]['min_amount']
    end
    product
  end

  def discount (check_item)
    @tmp
    if check_item['discount_code'] == "discount" and check_item['amount'] >= check_item['min_amount']
      @tmp = check_item['amount'] * check_item['cost'] / 100 * (100-check_item['percentage'])
    elsif check_item['discount_code'] == "one_for_free" and check_item['amount'] >= check_item['min_amount']
      check_item['amount'] = check_item['amount'] - check_item['amount'].to_i / check_item['min_amount'].to_i
      @tmp = check_item['amount']*check_item['cost']
    else
      @tmp = check_item['amount']*check_item['cost']
    end
    @tmp
  end

end