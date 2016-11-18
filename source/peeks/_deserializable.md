```ruby
class DeserializablePost < JSONAPI::Deserializable::Resource
  attribute :title

  attribute :date do |attr|
    field created_at: attr
  end

  relationship :author do |_rel, id, type|
    field author_id: id
    field author_type: type
  end

  relationship :comments do |_rel, ids, _types|
    field comment_ids: ids
  end
end
```
