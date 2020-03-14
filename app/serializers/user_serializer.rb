class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :password_digest, :about, :profile_picture
end
