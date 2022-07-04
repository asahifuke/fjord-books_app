# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let(:user) { create(:user) }

  it 'メールアドレスとパスワードを使ったログイン' do
    visit new_user_session_path
    fill_in 'Eメール', with: user.email
    fill_in 'パスワード', with: user.password
    click_on 'ログイン'
    expect(page).to have_content 'ログインしました'
  end

  it 'メアドとパスワードでログインするユーザーを2人以上作ることができる。' do
    visit new_user_registration_path
    fill_in 'Eメール', with: 'bob@gmail.com'
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード（確認用）', with: 'password'
    click_on 'サインアップ'
    expect(page).to have_content 'アカウント登録が完了しました。'
    click_on 'ログアウト'

    visit new_user_registration_path
    fill_in 'Eメール', with: 'cavin@gmail.com'
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード（確認用）', with: 'password'
    click_on 'サインアップ'
    expect(page).to have_content 'アカウント登録が完了しました。'
  end

  it 'パスワードを変更する場合は、現在のパスワードの入力してプロフィールを編集できるようにする' do
    sign_in user
    visit edit_user_registration_path
    fill_in 'パスワード', with: 'password2'
    fill_in 'パスワード（確認用）', with: 'password2'
    fill_in '現在のパスワード', with: 'password'
    click_on '更新'
    expect(page).to have_content 'アカウント情報を変更しました。'
  end

  it 'パスワードを変更する場合は、現在のパスワードの入力しないとプロフィールを編集できないようにする' do
    sign_in user
    visit edit_user_registration_path
    fill_in 'パスワード', with: 'password2'
    fill_in 'パスワード（確認用）', with: 'password2'
    click_on '更新'
    expect(page).to have_content '現在のパスワードを入力してください'
  end

  it 'パスワードを変更しない場合は、現在のパスワードの入力なしにプロフィールを編集できるようにする' do
    sign_in user
    visit edit_user_registration_path
    fill_in '氏名', with: 'こうのげんと'
    click_on '更新'
    expect(page).to have_content 'アカウント情報を変更しました。'
  end
end
