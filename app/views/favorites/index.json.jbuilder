json.array!(@favorites) do |favorite|
  json.extract! favorite, :id, :user_id, :post_id
  json.url favorite_url(favorite, format: :json)
end
