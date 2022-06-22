# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Follows', type: :system do
  fixtures :users

  let(:alice) { users(:alice) }
  let(:bob) { users(:bob) }

  before do
    sign_in alice
  end

  context '必須要件' do
    it 'ユーザー詳細画面にアクセスしてそのユーザーをフォローできるようにする（フォローボタンの設置）' do
      sign_out :users
      sign_in bob
      visit user_path(alice)
      click_on 'フォローする'
      expect(page).to have_content 'フォローを外す'
    end

    it 'すでにフォローしてる場合はフォロー解除できるようにする（フォロー解除ボタンの設置）' do
      visit user_path(bob)
      click_on 'フォローを外す'
      expect(page).to have_content 'フォローする'
    end

    it '自分自身のユーザー詳細画面ではフォローもフォロー解除もできない' do
      visit user_path(alice)
      expect(page).not_to have_content 'フォローを外す'
      expect(page).not_to have_content 'フォローを外す'
    end

    it 'ユーザー詳細画面に現在のフォロー数（そのユーザーがフォローしているユーザーの人数）とフォロワー数を表示する' do
      visit user_path(bob)
      expect(page).to have_text 'フォロー数: 1'
      expect(page).to have_text 'フォロワー数: 1'
    end

    it 'ユーザー詳細画面からフォロー一覧画面に遷移できるようにする' do
      visit user_path(bob)
      click_on 'フォロー数: 1'
      expect(page).to have_selector 'h1', text: 'フォロー'
    end

    it 'ユーザー詳細画面からフォロワー一覧画面に遷移できるようにする' do
      visit user_path(bob)
      click_on 'フォロワー数: 1'
      expect(page).to have_selector 'h1', text: 'フォロワー'
    end

    # it 'ユーザー詳細画面、フォロー一覧画面、フォロワー一覧画面のスクリーンショットを載せる'
    # it 'rubocopをパスさせる（要スクリーンショット）'
  end
end
