---
layout: guides
---
# Deserialization - Defining custom deserializable resources

Custom deserializable resources are defined by subclassing
`JSONAPI::Deserializable::Resource` and using its DSL.

Example:

```ruby
class DeserializablePost < JSONAPI::Deserializable::Resource
  attribute :date do |attr|
    { created_at: attr }
  end

  relationship :author do |_rel, id, type|
    { user_id: id,
      user_type: type }
  end

  relationship :comments do |_rel, ids, _types|
    { response_ids: ids }
  end
end

# Will allow to build the following hash:
# => {
#      type: 'posts',
#      id: '5',
#      created_at: '2016-11-18',
#      title: 'Hello JSON API',
#      user_id: '12',
#      user_type: 'users',
#      response_ids: ['54', '32', '72']
#    }
```

The principle is simple: the payload elements for which a custom deserialization
scheme was defined will use that, while other fields will be deserialized using
the default deserialization scheme (which can itself be configured).

Note: If the targeted element does not exist in the payload, the corresponding
fields are not defined.

## Type

The type of the primary data can be accessed via the `type` DSL method.

Example:

```ruby
class DeserializablePost < JSONAPI::Deserializable::Post
  # ...
  type do |t|
    { primary_type: t.capitalize }
  end
end
```

## Id

The id of the primary data can be accessed via the `id` DSL method.

Example:

```ruby
class DeserializablePost < JSONAPI::Deserializable::Post
  # ...
  id do |i|
    { primary_id: i.to_i }
  end
end
```

## Attributes

Attributes of the primary data can be accessed via the `attribute` DSL method.
The `attribute` method takes a symbol representing the name of the targeted
attribute in the input payload, and a block to define field(s) of the resulting
hash.

Example:

```ruby
class DeserializablePost < JSONAPI::Deserializable::Post
  # ...
  attribute :date do |d|
    { created_at: d }
  end
end
```

## Relationships

Relationships of the primary data can be accessed via the `has_many` and
`has_one` DSL methods.

### To-many relationships

The `has_many` DSL method takes a symbol representing the name of the targeted
relationship in the input payload, and a block to define field(s) of the
resulting hash. The block is called with three parameters: `relationship` (the
whole relationship hash of the input payload), `ids` (an array of the ids of
related resources), and `types` (an array of types of the related resources).

Example:

```ruby
class DeserializablePost < JSONAPI::Deserializable::Post
  # ...
  has_many :comments do |rel, ids, types|
    { comment_ids: ids,
      comment_types: types.map(&:capitalize),
      comment_meta: rel['meta'] }
  end
end
```

### To-one relationships

The `has_one` DSL method takes a symbol representing the name of the targeted
relationship in the input payload, and a block to define field(s) of the
resulting hash. The block is called with three parameters: `relationship` (the
whole relationship hash of the input payload), `id` (the id of the related
resource), and `type` (the type of the related resource).

Example:

```ruby
class DeserializablePost < JSONAPI::Deserializable::Post
  # ...
  has_one :author do |rel, id, type|
    { author_id: id,
      author_type: type.capitalize,
      author_meta: rel['meta'] }
  end
end
```

## Meta

Not available yet.

## Links

Not available yet.

## Configuration

The default deserialization scheme can be configure in the following way:

```ruby
# Modifying the global default deserialization scheme
JSONAPI::Deserializable::Resource.configure do |config|
  config.default_id   = proc { |id| { id: id } }
  config.default_type = proc { |type| { type: type } }
  config.default_attribute = proc do |key, value|
    { key => value }
  end
  config.default_has_one = proc do |key, rel, id, type|
    { "#{key}_id}".to_sym => id, "#{key}_type".to_sym => type }
  end
  config.default_has_many = proc do |key, rel, ids, types|
    { "#{key}_ids}".to_sym => ids, "#{key}_types".to_sym => types }
  end
end

# Modifying the default deserialization scheme of a single deserializable
#   resource class

class DeserializablePost < JSONAPI::Deserializable::Resource
  # ...
end

DeserializablePost.configure do |config|
  config.default_id   = proc { |id| { id: id } }
  config.default_type = proc { |type| { type: type } }
  config.default_attribute = proc do |key, value|
    { key => value }
  end
  config.default_has_one = proc do |key, rel, id, type|
    { "#{key}_id".to_sym => id, "#{key}_type".to_sym => type }
  end
  config.default_has_many = proc do |key, rel, ids, types|
    { "#{key}_ids".to_sym => ids, "#{key}_types".to_sym => types }
  end
end
```
