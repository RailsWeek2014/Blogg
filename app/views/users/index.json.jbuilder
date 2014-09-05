json.array!(@users) do |user|
  json.extract! user, :id, :nickname, :name, :birthday, :city, :info, :homepage
  json.url user_url(user, format: :json)
end
