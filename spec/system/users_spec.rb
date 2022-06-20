# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :system do
  fixtures :users
  let(:bob) { users(:bob) }

  def upload
    visit edit_user_registration_path
    attach_file '画像', Rails.root.join('spec/fixtures/images/test.png')
    fill_in '現在のパスワード', with: 'password'
    click_on '更新'
  end

  it 'ユーザーが自分のアイコン画像をアップロードできるようにする' do
    sign_out :users
    visit new_user_registration_path
    fill_in 'Eメール', with: 'alice@gmail.com'
    attach_file '画像', Rails.root.join('spec/fixtures/images/test.png')
    fill_in '氏名', with: 'alice@gmail.com'
    fill_in '郵便番号', with: '192-0918'
    fill_in '住所', with: '東京都八王子市兵衛8-2-5'
    fill_in '自己紹介文', with: 'よろしくお願いします'
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード（確認用）', with: 'password'
    click_button 'アカウント登録'
    assert_text 'アカウント登録が完了しました。'
  end

  it 'ユーザー一覧画面にアイコンを表示する' do
    sign_in bob
    upload
    visit users_path
    expect(page).to have_selector("img[src$='test.png']")
  end

  it 'ユーザー一覧画面に未アップロードなら何も表示しない' do
    sign_in bob
    visit users_path
    expect(page).not_to have_selector("img[src$='test.png']")
  end

  it 'ユーザー詳細画面にアイコンを表示する' do
    sign_in bob
    upload
    visit user_path(bob)
    expect(page).to have_selector("img[src$='test.png']")
  end

  it 'ユーザー詳細画面に未アップロードなら何も表示しない' do
    sign_in bob
    visit user_path(bob)
    expect(page).not_to have_selector("img[src$='test.png']")
  end

  it '画像アップロード用に追加した項目はi18nのYAMLファイルを編集して項目名を表示させよう（英語化は考慮不要）' do
    sign_out :users
    visit new_user_registration_path
    assert_text '画像'
    sign_in bob
    visit edit_user_registration_path
    assert_text '画像'
    visit users_path
    assert_text '画像'
  end
end
