json.array!(@members) do |member|
  json.extract! member, :id, :name, :photo, :position, :junior_enterprise_id, :phone, :email
  json.url member_url(member, format: :json)
end
