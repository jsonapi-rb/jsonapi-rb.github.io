# Serialization
JSONAPI::Serializable::Renderer.render(posts,
                                       namespace: 'API',
                                       expose: { url_helpers: MyUrlHelper.new },
                                       include: [:author, comments: [:author]],
                                       fields: { users: [:name, :email] })
# => { data: [...], included: [...] }

# Deserialization
DeserializablePost.call(json_hash)
# => {
#      title: 'Welcome',
#      created_at: '2016-11-17',
#      author_id: '5',
#      author_type: 'users',
#      comment_ids: ['13', '29', '31']
#    }
