# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  setup do
    @bob_report = Report.find_by(user_id: 902541635)
  end

  test "editable?のテスト" do
    alice = User.find_by(email: 'alice@email.com')
    bob   = User.find_by(email: 'bob@email.com')
    assert @bob_report.editable?(bob)
    refute @bob_report.editable?(alice)
  end

  test "created_onのテスト" do
    assert_equal Time.now.to_date, @bob_report.created_at.to_date
  end
end
