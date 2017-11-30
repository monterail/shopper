json.extract! order, :id, :product_id, :user_id, :price, :quantity, :payment_status, :created_at, :updated_at
json.url order_url(order, format: :json)
