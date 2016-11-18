```ruby
class SerializablePost < JSONAPI::Serializable::Resource
  type 'posts'

  attributes :title, :body

  attribute :date do
    @object.created_at
  end

  belongs_to :author

  has_many :comments, 'V2::SerializableComment' do
    resources do
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
