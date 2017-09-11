```ruby
# Gemfile
gem 'jsonapi-rb'

# Serialization
require 'jsonapi/serializable'

renderer = JSONAPI::Serializable::Renderer.new

renderer.render(
  posts,
  class: { User: SerializableUser, Comment: SerializableComment },
  expose: { url_helpers: MyUrlHelper.new },
  include: [:author, comments: [:author]],
  fields: { users: [:name, :email] }
)
# => { data: [...], included: [...] }

# Deserialization
require 'jsonapi/deserializable'

resource = JSONAPI::Deserializable::Resource.new(json_hash)
resource.to_h
# => {
#      title: 'Welcome',
#      date: '2016-11-17',
#      author_id: '5',
#      author_type: 'users',
#      comments_ids: ['13', '29', '31'],
#      comments_types: ['comments', 'comments', 'comments']
#    }
```
