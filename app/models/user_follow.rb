# frozen_string_literal: true

class UserFollow < ApplicationRecord
  belongs_to :followed, class_name: 'User'
  belongs_to :follower, class_name: 'User'
end
