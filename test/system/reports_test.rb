# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @alice = users(:alice)
  end

  test 'メールアドレスとパスワードでログインして日報を書く' do
    sign_out :user
    visit new_user_session_path
    fill_in 'Eメール', with: 'alice@email.com'
    fill_in 'パスワード', with: 'password'
    click_on 'ログイン'
    assert_text 'ログインしました。'
    click_on '日報'
    assert_selector 'h1', text: '日報'
    click_on '新規作成'
    fill_in 'タイトル', with: 'alice@email.com'
    fill_in '内容', with: 'password'
    click_on '登録する'
    assert_text '日報が作成されました。'
  end

  test '日報の編集' do
    sign_out :user
    sign_in users(:alice)
    visit reports_path
    click_on '編集'
    fill_in 'タイトル', with: '日報のタイトルの更新'
    fill_in '内容', with: '日報の内容の更新'
    click_on '更新する'
    assert_text '日報が更新されました。'
  end

  test '日報の削除' do
    sign_out :user
    sign_in users(:alice)
    visit reports_path
    page.accept_confirm do
      click_on '削除', match: :first
    end

    assert_text '日報が削除されました。'
  end
end
