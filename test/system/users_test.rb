require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers
  setup do
    @user = users(:alice)
  end

  test 'ログインページのテスト' do
    visit new_user_session_path
    assert_selector 'h2', text: 'ログイン'
  end

  test 'ログインのテスト' do
    visit new_user_session_path
    fill_in 'Email', with: 'alice@gamil.com'
    fill_in 'Password', with: 'password'
    click_on 'Log in'
    assert_text 'translation missing: ja.devise.sessions.user.signed_in'
  end

  test 'サインアップページのテスト' do
    visit new_user_registration_path
    assert_selector 'h2', text: 'サインアップ'
  end

  test 'サインアップのテスト' do
    visit new_user_registration_path
    fill_in 'Email', with: 'bob@gamil.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_on 'Sign up'
    assert_text 'translation missing: ja.devise.registrations.user.signed_up'
  end

  test 'ユーザーの一覧画面のテスト' do
    visit users_path
    assert_selector 'h1', text: 'ユーザー一覧画面'
  end

  test 'ユーザーの詳細画面のテスト' do
    visit user_path(@user)
    assert_selector 'h1', text: 'ユーザー詳細画面'
  end

  test 'ユーザーの編集画面のテスト' do
    sign_in @user
    visit edit_user_path(@user)
    assert_selector 'h1', text: 'ユーザー編集画面'
  end

  test '別のユーザーが編集できないテスト' do
    visit new_user_registration_path
    fill_in 'Email', with: 'Dave@gamil.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_on 'Sign up'
    visit edit_user_path(@user)
    assert_selector 'h1', text: 'ユーザー詳細画面'
  end

  test 'ユーザーの更新のテスト' do
    sign_in @user
    visit edit_user_path(@user)
    fill_in 'Email', with: 'carol@gamil.com'
    fill_in 'Address', with: '青森県青森市長島一丁目1-1'
    fill_in 'Zip code', with: '030-8570'
    fill_in 'Introduction', with: 'よろしくお願いします。'
    click_on '更新する'
    assert_text 'ユーザーを正常に更新できました'
  end
end
