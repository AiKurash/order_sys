json.extract! order, :id, :name, :description, :order_status, :user_id, :created_at, :updated_at
json.url order_url(order, format: :json)
