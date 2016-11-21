---
layout: guides
---
# Deserialization - Deserializing resources

Deserializing an input payload is straightforward: simply call it.

Example:

```ruby
DeserializablePost.call(json_hash)
# => {
#      type: 'posts',
#      id: '5',
#      created_at: '2016-11-18',
#      author_id: '12',
#      author_type: 'users',
#      comment_ids: ['54', '32', '72']
#    }
```

## Rails

When using jsonapi-rails, you can specify resources to deserialize at the
controller level via the `deserializable_resource` method. This method takes
a symbol along with a symbol representing a deserializable resource class, or a
block for inline definition.

The deserialized hash is then available in `params` as the specified key, and
is in fact a normal param (which can be validated using strong parameters or
some validation library like [dry-validation](http://dry-rb.org)).

Moreover, this method accepts the optional parameters `only` and `except` for
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
action level via the `deserializable_resource` method. This method takes
a symbol along with a symbol representing a deserializable resource class, or a
block for inline definition.

The deserialized hash is then available in `params` as the specified key, and
is in fact a normal param (which can be validated using hanami-validations or
some validation library like [dry-validation](http://dry-rb.org)).

Example:

```ruby
class API::Controllers::Create
  include API::Action
  include JSONAPI::Hanami::Action

  desierializable_resource :post, DeserializablePost

  params do
    # validations on params[:post]
  end

  def call(params)
    post = PostRepository.new.create(params[:post])
    # ...
  end
end
```
