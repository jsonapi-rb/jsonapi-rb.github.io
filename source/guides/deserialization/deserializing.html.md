---
layout: guides
---
# Deserialization - Deserializing resources

Deserializing an input payload is straightforward: simply call the
deserializable resource.

Example (generic deserializable resource):

```ruby
JSONAPI::Deserializable::Resource.call(json_hash)
# => {
#      type: 'posts',
#      id: '5',
#      title: 'Hello JSON API',
#      date: '2016-11-18',
#      author_id: '12',
#      author_type: 'users',
#      comments_ids: ['54', '32', '72']
#      comments_types: ['comments', 'comments', 'comments']
#    }
```

Example (custom deserializable resource):

```ruby
DeserializablePost.call(json_hash)
# => {
#      type: 'posts',
#      id: '5',
#      title: 'Hello JSON API',
#      created_at: '2016-11-18',
#      author_id: '12',
#      author_type: 'users',
#      comment_ids: ['54', '32', '72']
#    }
```

## Rails

When using jsonapi-rails, you can specify resources to deserialize at the
controller level via the `deserializable_resource` method. This method takes
a symbol representing the desired key under which the deserialized payload will
be available within `params`, along with an options hash, which may contain the
`class` option to specify a custom deserializable resource class. It is also
possible to pass it a block for inline definition of custom deserializable
resource classes.

The deserialized hash is then available in `params` as the specified key, and
is in fact a normal parameter (which can be validated using strong parameters or
some validation library like [dry-validation](http://dry-rb.org)).

Moreover, this method accepts the `only` and `except` options for
limiting the deserialization to certain actions.

Example:

```ruby
class PostsController < ApplicationController
  desierializable_resource :post, DeserializablePost, only: [:create, :update]

  # ...

  def create
    post = Post.create(create_params)
    # ...
  end

  private

  def create_params
    params.require(:post).permit(:title, :body)
  end
end
```

## Hanami

When using jsonapi-hanami, you can specify resources to deserialize at the
controller level via the `deserializable_resource` method. This method takes
a symbol representing the desired key under which the deserialized payload will
be available within `params`, along with an options hash, which may contain the
`class` option to specify a custom deserializable resource class. It is also
possible to pass it a block for inline definition of custom deserializable
resource classes.

The deserialized hash is then available in `params` as the specified key, and
is in fact a normal parameter (which can be validated using hanami-validations
or any other validation library).

Example:

```ruby
class API::Controllers::Create
  include API::Action
  include JSONAPI::Hanami::Action

  desierializable_resource :post

  params do
    # validations on params[:post]
  end

  def call(params)
    post = PostRepository.new.create(params[:post])
    # ...
  end
end
```
