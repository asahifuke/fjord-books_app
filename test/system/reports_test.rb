# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers
  setup do
    @alice_report = reports(:alice_report)
    @bob_report = reports(:bob_report)
    @sample_comment = 'コメント作成のテスト'
    @sample_update_comment = 'コメント更新のテスト'
    sign_in users(:alice)
    visit reports_path
    assert_text '日報'
  end

  test 'reportsの個別' do
    visit report_path(@alice_report)
    assert_text @alice_report.title
    assert_text @alice_report.body
  end

  test 'reportsの作成' do
    sample_title = '新規題目テスト'
    sample_body  = '新規本文テスト'
    click_on '新規作成'
    fill_in '題目', with: sample_title
    fill_in '本文', with: sample_body
    click_on '登録する'
    assert_text sample_title
    assert_text sample_body
  end

  test 'reportsの編集' do
    sample_title = '更新題目テスト'
    sample_body  = '更新本文テスト'
    visit edit_report_path(@alice_report)
    assert_text '日報の編集'
    fill_in '題目', with: sample_title
    fill_in '本文', with: sample_body
    click_on '更新する'
    assert_text sample_title
    assert_text sample_body
  end

  test 'reportsの削除' do
    page.accept_confirm do
      click_on '削除', match: :first
    end
  end

  test '日報を更新できるのはその日報を投稿した本人のみ（本のCRUDは特に制限なし）' do
    visit edit_report_path(@bob_report)
    assert_text '新規作成'
  end

  test '日報を削除できるのはその日報を投稿した本人のみ' do
    page.accept_confirm do
      click_on '削除', match: :first
    end
  end

  test '本の詳細画面からコメントを投稿できるようにする。投稿したコメントは本の各詳細画面から確認できる。投稿した内容に加えて、投稿したユーザーの名前（未入力ならメアド）と投稿日時も表示する' do
    visit books_path
    assert_text '本'
    click_on '詳細', match: :first
    assert_text '本の詳細'
    fill_in '本文', with: @sample_comment
    click_on '登録する'
    assert_text @sample_comment
    assert_text 'alice'
    assert_text Time.zone.today.strftime('%Y年%m月%d日')
  end

  test '日報の詳細画面からコメントを投稿できるようにする。投稿したコメントは日報の詳細画面から確認できる。投稿した内容に加えて、投稿したユーザーの名前（未入力ならメアド）と投稿日時も表示する。' do
    visit reports_path
    assert_text '日報'
    click_on '詳細', match: :first
    assert_text '日報の詳細'
    fill_in '本文', with: @sample_comment
    click_on '登録する'
    assert_text @sample_comment
    assert_text 'alice'
    assert_text Time.zone.today.strftime('%Y年%m月%d日')
  end

  test 'コメントが1件もない場合はその旨を画面に表示する' do
    visit report_path(@alice_report)
    assert_text 'コメントは1件もありません'
  end

  test 'コメントの編集ができるようにする' do
    visit reports_path
    click_on '詳細', match: :first
    fill_in '本文', with: @sample_comment
    click_on '登録する'
    click_on '編集', match: :prefer_exact
    fill_in '本文', with: @sample_update_comment
    click_on '更新する'
    assert_text @sample_update_comment
  end

  test 'コメントの削除ができるようにする' do
    visit reports_path
    click_on '詳細', match: :first
    fill_in '本文', with: @sample_comment
    click_on '登録する'
    page.accept_confirm do
      click_on '削除', match: :prefer_exact
    end
  end
end
