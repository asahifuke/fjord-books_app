# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @alice = users(:alice)
    @bob   = users(:bob)
    @carol = users(:carol)
  end

  # ！！注意！！どれだけテストするか質問する
  test "following?のテスト" do
    assert @alice.following?(@bob)
    refute @alice.following?(@carol)
  end

  # ！！注意！！どれだけテストするか質問する
  test "followed_by?のテスト" do
    assert @bob.followed_by?(@alice)
    refute @alice.followed_by?(@bob)
  end

  test "follow・unfollowのテスト" do
    refute @bob.following?(@carol)
    @bob.follow(@carol)
    assert @bob.following?(@carol)
    @bob.unfollow(@carol)
    refute @bob.following?(@carol)
  end

  test "name_or_emailのテスト" do
    assert_equal @alice.name, @alice.name_or_email
    assert_equal @bob.email,  @bob.name_or_email
  end
end
