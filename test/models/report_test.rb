# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  setup do
    @bob_report = reports(:bob_report)
  end

  test 'editable?のテスト' do
    alice = users(:alice)
    bob   = users(:bob)
    assert @bob_report.editable?(bob)
    assert_not @bob_report.editable?(alice)
  end

  test 'created_onのテスト' do
    assert_equal Time.zone.now.to_date, @bob_report.created_at.to_date
  end
end
