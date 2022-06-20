# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @alice = users(:alice)
  end

  test 'メールアドレスとパスワードでログインして日報を書く' do
    title = '日報のタイトルの作成'
    content = '日報の内容の作成'
    sign_out :user
    visit new_user_session_path
    fill_in 'Eメール', with: 'alice@email.com'
    fill_in 'パスワード', with: 'password'
    click_on 'ログイン'
    assert_text 'ログインしました。'
    click_on '日報'
    assert_selector 'h1', text: '日報'
    click_on '新規作成'
    fill_in 'タイトル', with: title
    fill_in '内容', with: content
    click_on '登録する'
    assert_text '日報が作成されました。'
    assert_text title
    assert_text content
  end

  test '日報の編集' do
    title = '日報のタイトルの更新'
    content = '日報の内容の更新'
    alice_report = reports(:alice_report)
    sign_out :user
    sign_in users(:alice)
    visit report_path(alice_report)
    assert_no_text title
    assert_no_text content
    click_on '編集'
    fill_in 'タイトル', with: title
    fill_in '内容', with: content
    click_on '更新する'
    assert_text '日報が更新されました。'
    assert_text title
    assert_text content
  end

  test '日報の削除' do
    alice_report = reports(:alice_report)
    sign_out :user
    sign_in users(:alice)
    visit reports_path
    assert_text alice_report.title
    page.accept_confirm do
      click_on '削除', match: :first
    end
    assert_text '日報が削除されました。'
    assert_no_text alice_report.title
  end
end
