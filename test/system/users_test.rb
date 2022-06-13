require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers
  setup do
    @alice = users(:alice)
    @dave = users(:dave)
  end

  test 'Eメールとパスワードを入力してアカウント登録ができる（confirmableの対応は不要）' do
    visit new_user_registration_path
    fill_in 'Eメール', with: 'bob@gamil.com'
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード（確認用）', with: 'password'
    click_button 'アカウント登録'
    assert_text 'アカウント登録が完了しました。'
  end

  test 'Eメールとパスワードでログインできる' do
    visit new_user_session_path
    fill_in 'Eメール', with: 'alice@gamil.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
    assert_text 'ログインしました。'
  end

  test 'ログインしたユーザーはログアウトできる' do
    sign_in @alice
    visit users_path
    click_on 'ログアウト'
    assert_text 'ログアウトしました。'
  end

  test 'ユーザーの一覧画面のテスト' do
    sign_in @alice
    visit users_path
    assert_selector 'h1', text: 'ユーザー'
    assert_text 'Eメール'
    assert_text '郵便番号'
    assert_text '住所'
    assert_text '自己紹介文'
    assert_text '次'
  end

  test 'ユーザーの詳細画面のテスト' do
    sign_in @alice
    visit user_path(@alice)
    assert_text 'Eメール'
    assert_text '郵便番号'
    assert_text '住所'
    assert_text '自己紹介文'
  end

  test 'アプリの利用にはログインを必須とする' do
    visit users_path
    assert_selector 'h2', text: 'ログイン'
    visit user_path(@alice)
    assert_selector 'h2', text: 'ログイン'
    visit edit_user_registration_path
    assert_selector 'h2', text: 'ログイン'
  end

  test 'アカウント編集ページで自分のEメールとパスワード、郵便番号、住所と自己紹介文を編集できる' do
    sign_in @alice
    visit edit_user_registration_path
    fill_in 'Eメール', with: 'carol@gamil.com'
    fill_in '郵便番号', with: '030-8570'
    fill_in '住所', with: '青森県青森市長島一丁目1-1'
    fill_in '自己紹介文', with: 'よろしくお願いします。'
    fill_in 'パスワード', with: 'password2'
    fill_in 'パスワード（確認用）', with: 'password2'
    fill_in '現在のパスワード', with: 'password'
    click_on '更新'
    assert_text 'アカウント情報を変更しました。'
  end

  # # test 'パスワードを忘れたらパスワード再設定メールを経由してパスワードを再設定できる' do
  # # end

  test 'Deviseが用意した画面も日本語で表示する。それ以外の新しく追加した画面もi18nで日本語化する（英語表示は考慮不要）' do
    visit new_user_session_path
    assert_selector 'h2', text: 'ログイン'
    assert_text 'Eメール'
    assert_text 'パスワード'
    assert_text 'ログインを記憶する'
    assert_text 'アカウント登録'
    assert_text 'パスワードを忘れましたか？'

    visit new_user_registration_path
    assert_selector 'h2', text: 'アカウント登録'
    assert_text 'Eメール'
    assert_text 'パスワード'
    assert_text '（6字以上）'
    assert_text 'パスワード（確認用）'
    assert_text 'ログイン'
    assert_text 'アカウント登録'
  end
end
