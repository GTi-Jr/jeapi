json.array!(@users) do |user|
  json.extract! user, :id, :password, :permission
  json.url user_url(user, format: :json)
end
