class Message < ActiveRecord::Base
  attr_accessible(:title, :content, :read, :user_id)
  belongs_to :user
end
