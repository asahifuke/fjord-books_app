# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @alice = users(:alice)
    @bob   = users(:bob)
    @carol = users(:carol)
  end

  test 'following?のテスト' do
    assert @alice.following?(@bob)
    assert_not @alice.following?(@carol)
  end

  test 'followed_by?のテスト' do
    assert @bob.followed_by?(@alice)
    assert_not @alice.followed_by?(@bob)
  end

  test 'follow・unfollowのテスト' do
    assert_not @bob.following?(@carol)
    @bob.follow(@carol)
    assert @bob.following?(@carol)
    @bob.unfollow(@carol)
    assert_not @bob.following?(@carol)
  end

  test 'name_or_emailのテスト' do
    assert_equal @alice.name, @alice.name_or_email
    assert_equal @bob.email,  @bob.name_or_email
  end
end
