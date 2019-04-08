```ruby
# Gemfile
gem 'jsonapi-rails'

# app/controllers/posts_controller.rb
class PostsController < ApplicationController
  deserializable_resource :post, only: [:create, :update]

  def create_params
    params.require(:post).permit(:title, :content, :tag_ids)
  end

  def create
    post = Post.create(create_params)
    render jsonapi: post,
           include: [:author, comments: [:author]],
           fields: { users: [:name, :email] },
           status: :created
  end
end
```

Further instructions are in the [getting started guide for Rails](guides/getting_started/rails).
