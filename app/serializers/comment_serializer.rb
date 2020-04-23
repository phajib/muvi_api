class CommentSerializer < ActiveModel::Serializer
  attributes :id, :username, :profile_picture, :user_id, :movie_id, :content, :movie_title
  # attributes :user_id, :movie_id, :content, :movie_title
end
