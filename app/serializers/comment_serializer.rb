class CommentSerializer < ActiveModel::Serializer
  attributes :id, :username, :user_id, :movie_id, :content, :rating, :movie_title
end
