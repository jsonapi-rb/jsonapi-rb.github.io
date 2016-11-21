---
layout: guides
---
# Serialization - Defining resources

Serializable resources are defined by subclassing
`JSONAPI::Serializable::Resource` and using its DSL.

Example:

```ruby
class SerializablePost < JSONAPI::Serializable::Resource
  type 'posts'

  attributes :title, :body

  attribute :date do
    @object.created_at
  end

  belongs_to :author

  has_many :comments, 'V2::SerializableComment' do
    data do
      @object.published_comments
    end

    link :related do
      @url_helpers.user_posts_url(@object.id)
    end

    meta do
      { count: @object.published_comments.count }
    end
  end

  link :self do
    @url_helpers.post_url(@object.id)
  end

  meta do
    { featured: true }
  end
end
```

The principle is simple: you declare elements of the JSON API resource and
specify their values.

The underying object is available throughout the DSL as the instance variable
`@object`. (In general, all *exposures* - that is, variables made available in
the `render` call - are available throughout the DSL as instance variables.)

## Type

The `type` property is declared via the DSL method of the same name, and takes
a symbol or a string.

Example:

```ruby
class SerializablePost < JSONAPI::Serializable::Resource
  type 'posts'
end
```

## Id

The `id` property is declared via the DSL method of the same name, and takes a
block. If no id is explicitly declared, it will default to `@object.id`.

Example:

```ruby
class SerializablePost < JSONAPI::Serializable::Resource
  # ...
  id { @object.uuid }
end
```

## Attributes

Attributes are declared either via the `attribute` (singular) or `attributes`
(plural) DSL methods. The former allows to specify an explicit value for the
attribute (if a block is provided), whereas the latter only allows implicit
definition of the values (they will be determined by calling methods named
after the attributes on the underlying object).

Example:

```ruby
class SerializablePost < JSONAPI::Serializable::Resource
  # ...
  attribute :date  # This will have value @object.date
  attribute :date do
    @object.created_at
  end

  attributes :title, :content
end
```

## Meta

Meta information can be declared via the `meta` DSL method. The value can either
be set directly as a hash:

```ruby
class SerializablePost < JSONAPI::Serializable::Resource
  # ...
  meta foo: 'bar'
end
```
or dynamically in a block:

```ruby
class SerializablePost < JSONAPI::Serializable::Resource
  # ...
  meta do
    { foo: 'bar' }
  end
end
```

## Links

Links are declared via the `link` DSL method. The value can either be set
directly as a string:

```ruby
class SerializablePost < JSONAPI::Serializable::Resource
  # ...
  link :self do
    "http://api.example.com/posts/#{@object.id}"
  end
end
```
or built via the `href` and `meta` DSL methods:

```ruby
class SerializablePost < JSONAPI::Serializable::Resource
  # ...
  link :self do
    href "http://api.example.com/posts/#{@object.id}"
    meta public: true
  end
end
```

## Relationships

Relationships are declared via the `has_many`, `has_one` and `belongs_to` DSL
methods. `belongs_to` is actually an alias for `has_one`, and you can use both
interchangeably.

### Basics

The shortest way to declare an association is simply:

```ruby
class SerializablePost < JSONAPI::Serializable::Resource
  # ...
  has_many :comments
end
```

This will set the value of the relationship by calling the method of the same
name on the underlying object.

It is also possible to explicitly define the value of a relationship via the
`data` DSL method.

Example:

```ruby
class SerializablePost < JSONAPI::Serializable::Resource
  # ...
  has_many :comments do
    data do
      @object.published_comments
    end
  end
end
```

### Relationship-level links and meta

Moreover, it is possible to declare links and meta informations inside a
relationship via the `meta` and `link` DSL methods, the same way as for
resource-level links and meta information.

Example:

```ruby
class SerializablePost < JSONAPI::Serializable::Resource
  # ...
  has_many :comments do
    link :self do
      "http://api.example.com/posts/#{@object.id}/relationships/comments"
    end
    meta foo: 'bar'
  end
end
```

### Serializable resource class inference

By default, for an instance of class `Post`, the corresponding serializable
resource class will be assumed to be `SerializablePost` (this behavior can be
configured, see next section).

In case you want to explicitly set the serializable resource class that will be
used for the related resources, you can specify it via the `class` option. Its
value can be either a constant:

```ruby
class SerializablePost < JSONAPI::Serializable::Resource
  # ...
  has_many :comments, class: New::SerializableComment
end
```
a string:

```ruby
class SerializablePost < JSONAPI::Serializable::Resource
  # ...
  has_many :comments, class: 'New::SerializableComment'
end
```
or a hash (for polymorphic relationships):

```ruby
class SerializablePost < JSONAPI::Serializable::Resource
  # ...
  has_one :author, class: { User: 'SpecialSerializableUser',
                            Admin: 'SpecialSerializableAdmin' }
end
```

### Linkage data overriding

Note: it is also possible to manually override the linkage data for a
relationship (which can be useful to add linkage-level meta information) via the
`linkage` DSL method.

## Rails generators

The jsonapi-rails gem comes with generators for serializable resource classes.
It infers the attributes and relationships from your model definition.

Usage:
```
$ bundle exec rails generate jsonapi:serializable Post
>   created  app/serializable/serializable_post.rb
```
