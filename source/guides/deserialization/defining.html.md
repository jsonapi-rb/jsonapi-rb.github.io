---
layout: guides
---
# Deserialization - Defining deserializable resources

Deserializable resources are defined by subclassing
`JSONAPI::Deserializable::Resource` and using its DSL.

Example:

```ruby
class DeserializablePost < JSONAPI::Deserializable::Resource
  type
  id
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

# Will allow to build the following hash:
# => {
#      type: 'posts',
#      id: '5',
#      created_at: '2016-11-18',
#      author_id: '12',
#      author_type: 'users',
#      comment_ids: ['54', '32', '72']
#    }
```

The principle is simple: mapping values of elements of the input payload to
fields of the result hash.

In other words, you declare which elements you are interested in, and which
fields you want to build from them (choosing the name and the value of the
field). If the targeted element does not exist in the payload, the corresponding
fields are not defined.

## Type

The type of the primary data can be accessed via the `type` DSL method. If no
block is given, it will create a field named `type`.

Example:

```ruby
class DeserializablePost < JSONAPI::Deserializable::Post
  # ...
  type do |t|
    field primary_type: t.capitalize
  end

  # or
  type  # implicitly expanded to `type { |t| field type: t }`
end
```

## Id

The id of the primary data can be accessed via the `id` DSL method. If no
block is given, it will create a field named `id`.

Example:

```ruby
class DeserializablePost < JSONAPI::Deserializable::Post
  # ...
  id do |i|
    field primary_id: i.to_i
  end

  # or
  id  # implicitly expanded to `id { |i| field id: i }`
end
```

## Attributes

Attributes of the primary data can be accessed via the `attribute` DSL method.
The `attribute` method takes a symbol representing the name of the targeted
attribute in the input payload, and a block to define field(s) of the resulting
hash.

If no block is given, it will create a field with the same name.

Example:

```ruby
class DeserializablePost < JSONAPI::Deserializable::Post
  # ...
  attribute :date do |d|
    field created_at: d
  end

  # or
  attribute :date  # implicitly expanded to `attribute(:date) { |d| field date: d }`
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
    field comment_ids: ids
    field comment_types: types.map(&:capitalize)
    field comment_meta: rel['meta']
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
    field author_id: id
    field author_type: type.capitalize
    field author_meta: rel['meta']
  end
end
```

## Meta

Not available yet.

## Links

Not available yet.


## Generators

### Rails

The jsonapi-rails gem comes with generators for deserializable resource classes.
They infer the attributes and relationships from your model definition.

Usage:

```
$ bundle exec rails generate jsonapi:deserializable Post
>   created  app/deserializable/deserializable_post.rb
```

### Hanami

Not available yet.
