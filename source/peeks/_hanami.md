```ruby
# Gemfile
gem 'jsonapi-hanami'

# apps/api/controllers/posts/create.rb
module API::Controllers::Posts
  class Create
    include API::Action
    include JSONAPI::Hanami::Action

    deserializable_resource :post

    params do
      required(:post).schema do
        required(:title)
        required(:content)
        required(:tag_ids)
      end
    end

    def call(params)
      repo = PostRepository.new
      post = repo.create(params[:post])

      self.data = post
      self.include = [:author, comments: [:author]]
      self.fields = { users: [:name, :email] }
      self.status = 201
    end
  end
end
```
