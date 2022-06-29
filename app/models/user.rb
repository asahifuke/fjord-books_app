# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  has_many :active_relationships, class_name: 'UserFollow', foreign_key: 'follower_id', dependent: :destroy
  has_many :passive_relationships, class_name: 'UserFollow', foreign_key: 'followed_id', dependent: :destroy
  has_many :followings, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships
end
