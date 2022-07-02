# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Reports', type: :system do
  fixtures :users, :reports, :books

  let(:alice_report) { reports(:alice_report) }
  let(:bob_report) { reports(:bob_report) }
  let(:sample_comment) { 'コメント作成のテスト' }
  let(:sample_update_comment) { 'コメント更新のテスト' }

  context '必須要件' do
    before do
      sign_in users(:alice)
      visit reports_path
      expect(page).to have_content '日報'
    end

    it 'reportsの個別' do
      visit report_path(alice_report)
      expect(page).to have_content alice_report.title
      expect(page).to have_content alice_report.body
    end

    it 'reportsの作成' do
      sample_title = '新規題目テスト'
      sample_body  = '新規本文テスト'
      expect(page).not_to have_content sample_title
      expect(page).not_to have_content sample_body
      click_on '新規作成'
      fill_in '題目', with: sample_title
      fill_in '本文', with: sample_body
      click_on '登録する'
      expect(page).to have_content sample_title
      expect(page).to have_content sample_body
    end

    it 'reportsの編集' do
      sample_title = '更新題目テスト'
      sample_body  = '更新本文テスト'
      visit edit_report_path(alice_report)
      expect(page).to have_content '日報の編集'
      fill_in '題目', with: sample_title
      fill_in '本文', with: sample_body
      click_on '更新する'
      expect(page).to have_content sample_title
      expect(page).to have_content sample_body
    end

    it 'reportsの削除' do
      page.accept_confirm do
        click_on '削除', match: :first
      end
      expect(page).not_to have_content alice_report.title
      expect(page).not_to have_content alice_report.body
    end

    it '日報を更新できるのはその日報を投稿した本人のみ（本のCRUDは特に制限なし）' do
      visit edit_report_path(bob_report)
      expect(page).to have_content '新規作成'
    end

    it '日報を削除できるのはその日報を投稿した本人のみ' do
      page.accept_confirm do
        click_on '削除', match: :first
      end
      expect(page).not_to have_content '削除'
    end

    it '本の詳細画面からコメントを投稿できるようにする。投稿したコメントは本の各詳細画面から確認できる。投稿した内容に加えて、投稿したユーザーの名前（未入力ならメアド）と投稿日時も表示する' do
      visit books_path
      expect(page).to have_content '本'
      click_on '詳細', match: :first
      expect(page).to have_content '本の詳細'
      fill_in '本文', with: sample_comment
      click_on '登録する'
      expect(page).to have_content sample_comment
      expect(page).to have_content 'alice'
      expect(page).to have_content Time.zone.today.strftime('%Y年%m月%d日')
    end

    it '日報の詳細画面からコメントを投稿できるようにする。投稿したコメントは日報の詳細画面から確認できる。投稿した内容に加えて、投稿したユーザーの名前（未入力ならメアド）と投稿日時も表示する。' do
      visit reports_path
      expect(page).to have_content '日報'
      click_on '詳細', match: :first
      expect(page).to have_content '日報の詳細'
      fill_in '本文', with: sample_comment
      click_on '登録する'
      expect(page).to have_content sample_comment
      expect(page).to have_content 'alice'
      expect(page).to have_content Time.zone.today.strftime('%Y年%m月%d日')
    end
  end

  context '歓迎要件' do
    before do
      sign_in users(:alice)
      visit reports_path
      expect(page).to have_content '日報'
    end

    it 'コメントが1件もない場合はその旨を画面に表示する' do
      visit report_path(alice_report)
      expect(page).to have_content 'コメントは1件もありません'
    end

    it 'コメントの編集ができるようにする' do
      visit reports_path
      click_on '詳細', match: :first
      fill_in '本文', with: sample_comment
      click_on '登録する'
      click_on '編集', match: :prefer_exact
      fill_in '本文', with: sample_update_comment
      click_on '更新する'
      expect(page).to have_content sample_update_comment
    end

    it 'コメントの削除ができるようにする' do
      visit reports_path
      click_on '詳細', match: :first
      fill_in '本文', with: sample_comment
      click_on '登録する'
      page.accept_confirm do
        click_on '削除', match: :prefer_exact
      end
      expect(page).not_to have_content '削除'
    end
  end
end
