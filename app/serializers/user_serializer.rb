class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :username, :password, :about, :profile_picture
end
