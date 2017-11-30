json.extract! user, :id, :email, :instant_payment_allowed, :created_at, :updated_at
json.url user_url(user, format: :json)
