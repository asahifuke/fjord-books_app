# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'アカウント登録', type: :system do
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
end
