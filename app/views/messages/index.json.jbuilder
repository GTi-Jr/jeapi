json.array!(@messages) do |message|
  json.extract! message, :id, :text, :email, :phone, :name, :junior_enterprise_id, :read
  json.url message_url(message, format: :json)
end
