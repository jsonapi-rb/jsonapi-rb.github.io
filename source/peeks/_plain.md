```ruby
# Gemfile
gem 'jsonapi-rb'

# Serialization
require 'jsonapi/serializable'

JSONAPI::Serializable::Renderer.render(posts,
                                       expose: { url_helpers: MyUrlHelper.new },
                                       include: [:author, comments: [:author]],
                                       fields: { users: [:name, :email] })
# => { data: [...], included: [...] }

# Deserialization
require 'jsonapi/deserializable'

JSONAPI::Deserializable::Resource.call(json_hash)
# => {
#      title: 'Welcome',
#      date: '2016-11-17',
#      author_id: '5',
#      author_type: 'users',
#      comment_ids: ['13', '29', '31'],
#      comment_types: ['comments', 'comments', 'comments']
#    }
```
