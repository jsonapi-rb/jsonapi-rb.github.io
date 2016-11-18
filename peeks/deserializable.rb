class DeserializablePost < JSONAPI::Deserializable::Resource
  attribute :title

  attriute :date do |attr|
    field created_at: attr
  end

  relationship :author do |id, type|
    field author_id: id
    field author_type: type
  end

  relationship :comments do |ids, _types|
    field comment_ids: ids
  end
end
