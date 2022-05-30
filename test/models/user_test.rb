# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @alice = users(:alice)
    @bob   = users(:bob)
    @carol = users(:carol)
    @dave  = users(:dave)
  end

  # test "following?のテスト" do
  #   assert @alice.following?(@bob)
  #   refute @alice.following?(@carol)
  #   refute @alice.following?(@dave)
  #   refute @bob.following?(@alice)
  #   refute @bob.following?(@carol)
  #   refute @bob.following?(@dave)
  #   refute @carol.following?(@alice)
  #   refute @carol.following?(@bob)
  #   assert @carol.following?(@dave)
  #   refute @dave.following?(@alice)
  #   refute @dave.following?(@bob)
  #   refute @dave.following?(@alice)
  #   [true, ]
  #   aaa.each do |aaa, bbb, ccc|
  #     if aaa
  #       assert @alice.following?(@bob)
  #     else
  #       refute @alice.following?(@carol)
  #     end
  #   end
  # end

  # test "followed_by?のテスト" do
  #   assert @alice.followed_by?(@alice)
  # end

  test "name_or_emailのテスト" do
    assert_equal @alice.name, @alice.name_or_email
    assert_equal @bob.email,  @bob.name_or_email
  end
end
