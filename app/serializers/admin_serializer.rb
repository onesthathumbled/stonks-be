class AdminSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :created_at

  attribute :created_date do |admin|
    admin.created_at && admin.created_at.strftime('%m/%d/%Y')
  end
end
