class SerializablePost < JSONAPI::Serializable::Model
  type 'posts'

  attributes :title, :body

  attribute :date do
    @model.created_at
  end

  belongs_to :author

  has_many :comments, V2::SerializableComment do
    resources do
      @model.published_comments
    end

    link :related do
      @url_helpers.user_posts_url(@model.id)
    end

    meta do
      { count: @model.published_comments.count }
    end
  end

  link :self do
    @url_helpers.post_url(@model.id)
  end

  meta do
    { featured: true }
  end
end
