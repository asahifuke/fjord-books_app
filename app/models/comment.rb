# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  def store(user)
    self.user_id = user.id
    save
  end
end
