require 'rails_helper'

RSpec.describe User, type: :system do
  it 'ユーザーが自分のアイコン画像をアップロードできるようにする' do
    visit new_user_registration_path
    fill_in 'Eメール', with: 'alice@gmail.com'
    attach_file 'Image', "#{Rails.root}/spec/fixtures/images/test.jpg"
    fill_in '氏名', with: 'alice@gmail.com'
    fill_in '郵便番号', with: '192-0918'
    fill_in '住所', with: '東京都八王子市兵衛8-2-5'
    fill_in '自己紹介文', with: 'よろしくお願いします'
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード（確認用）', with: 'password'
    click_button 'アカウント登録'
    assert_text 'アカウント登録が完了しました。'
  end
  # it 'ユーザー一覧画面にアイコンを表示する'
  # it 'ユーザー一覧画面に未アップロードなら何も表示しない'
  # it 'ユーザー詳細画面にアイコンを表示する'
  # it 'ユーザー詳細画面に未アップロードなら何も表示しない'
  # it '画像を表示する際、大きすぎる画像は適切なサイズにリサイズする（ファイルの容量を小さくしてネットワークの負荷を減らす）'
  # it '画像アップロード用に追加した項目はi18nのYAMLファイルを編集して項目名を表示させよう（英語化は考慮不要）'
  # it 'ユーザー一覧画面のスクリーンショットを載せる'
  # it 'ユーザー詳細画面のスクリーンショットを載せる'
  # it 'rubocopをパスさせる（要スクリーンショット）'
end
