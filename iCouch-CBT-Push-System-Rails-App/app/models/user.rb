class User < ActiveRecord::Base
  attr_accessible(:id, :device_token)
  has_many :messages
end
