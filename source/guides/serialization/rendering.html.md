---
layout: guides
---
# Serialization - Rendering documents

The renderer takes your business objects (which can be any ruby objects: POROs,
ActiveRecord models, or even plain hashes), along with some optional parameters
(`include`, `fields`, etc.), and builds the JSON API document.

## Plain ruby

When using jsonapi-rb in plain ruby (or from within a framework outside of a
controller), you can call the as follows:

```ruby
JSONAPI::Serializable::Renderer.render(posts)
```

You can also pass options to the renderer:

```ruby
JSONAPI::Serializable::Renderer.render(posts,
                                       include: [:author, comments: [:author]],
                                       fields:  { users: [:name, :email],
                                                  posts: [:title, :content] })
```

For a comprehensive list of renderer options, see [Renderer options]().

## Ruby on Rails

When using jsonapi-rb with Rails (via the jsonapi-rails gem), rendering is done
via the usual `render` controller method:

```ruby
render jsonapi: posts
```
and options are passed as named arguments:

```ruby
render jsonapi: posts,
       include: [:author, comments: [:author]],
       fields:  { users: [:name, :email],
                  posts: [:title, :content] }
```

For a comprehensive list of renderer options, see [Renderer options]().

## Hanami

When using jsonapi-rb with Hanami (via the jsonapi-hanami gem), enabling of
jsonapi-rb features is opt-in, and is done by including
`JSONAPI::Hanami::Action` in your actions.
Rendering is done by setting options directly on the controller action instance.
The primary data is set via the `self.body` setter.

Exposures are available from within the SerializableResource class as instance
variables.

Example:

```ruby
module API::Controllers::Posts
  include API::Action
  include JSONAPI::Hanami::Action

  expose :url_helpers

  class Create
    # ...
    @url_helpers = routes  # Will be available inside serializable resources.

    self.data = posts
    self.include = [:author, comments: [:author]]
    self.fields  = { users: [:name, :email],
                     posts: [:title, :content] }
  end
end
```

For a comprehensive list of renderer options, see [Renderer options]().

## Renderer options

The available options are:

+ data-related options:
  + `include`: the related resources to include in the document. This option can
    be specified as a string (e.g. `"author,comments.author"`), or as an array/
    hash of symbols (e.g. `[:author, comments: [:author]]`).
  + `fields`: a restricted set of fields for some or all resources. This option
    can be specified as a hash of arrays of symbols (e.g.
    `{ users: [:name, :email], posts: [:title, :content] }`).
  + `expose`: a hash of arbitrary variables that will be made available to the
    serializable resources as instance variables.
+ serializable resource class related options:
  + `class`: the serializable resource class(es) to be used for the primary
    data. This option can be specified as a constant (e.g. `SerializablePost`),
    as a string (e.g. `"SerializablePost"`), or as a hash (e.g.
    `{ Article: "SerializableFormattedArticle", Letter: "SerializableFormattedLetter" }`).
  + `namespace`: the namespace in which to look for serializable resource
    classes. This option can be specified as a constant (e.g. `V2`), or as a
    string (e.g. `"V2"`).
+ top level properties:
  + `links`: a set of top level links. This option can be specified as a hash.
  + `meta`: top level meta information. This option can be specified as a hash.
  + `jsonapi`: top level `jsonapi` object. This option can be specified as a
    hash.
+ framework-specific options: in Hanami and Rails, the usual options such as
`status` are respected.
