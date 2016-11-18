class PostsController < ApplicationController
  deserializable_resource :post, DeserializablePost, only: [:create, :update]

  def create_params
    params.require(:post).permit!
  end

  def create
    post = Post.create(create_params)
    render jsonapi: post,
           include: [:author, comments: [:author]],
           fields: { users: [:name, :email] },
           status: :created
  end
end
