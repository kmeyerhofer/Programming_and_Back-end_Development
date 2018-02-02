class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    quantity = updated_count if updated_count >= 0
  end
end

# fixing it in the way of changing `attr_reader` to `attr_accessor` then
# makes @quantity available outside the instance object bypassing
# update_quantity
