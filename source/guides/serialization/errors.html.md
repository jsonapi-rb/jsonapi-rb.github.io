---
layout: guides
---
# Serialization - Rendering errors

You can also use jsonapi-rb to render JSON API errors.

## Plain ruby

When using jsonapi-rb in plain ruby (or from within a framework outside of a
controller), you can render an errors document as follows:

```ruby
JSONAPI::Serializable::ErrorRenderer.render([
  JSONAPI::Serializable::Error.create({
    status: "422",
    source: { pointer: "/data/attributes/first-name" },
    title:  "Invalid Attribute",
    detail: "First name must contain at least three characters."
  })
])
```

## Ruby on Rails

When using jsonapi-rb with Rails (via the jsonapi-rails gem), rendering errors is done
via the usual `render` controller method by using the `jsonapi_errors` renderer:

```ruby
render jsonapi_errors: {
  status: "422",
  source: { "pointer": "/data/attributes/volume" },
  detail: "Volume does not, in fact, go to 11."
}
```

You can also pass `ActiveModel::Errors`

```ruby
render jsonapi_errors: post.errors
```

or you can pass an array of objects

```ruby
render jsonapi_errors: [post.errors, author.errors, {
  status: "400",
  detail: "JSON parse error - Expecting property name at line 1 column 2 (char 1)."
}]
```

## Hanami

Soon.
