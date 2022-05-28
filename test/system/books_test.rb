# frozen_string_literal: true

require 'application_system_test_case'

class BooksTest < ApplicationSystemTestCase
  setup do
    @book = books(:one)
  end

  test '一覧画面が表示できるか' do
    visit books_url
    assert_selector 'h1', text: '本'
  end

  test '本の新規作成できるか' do
    visit books_url
    click_on '新規作成'

    fill_in 'メモ', with: @book.memo
    fill_in '題名', with: @book.title
    click_on '登録する'

    assert_text '本が作成されました。'
    click_on '戻る'
  end

  test 'ページネーションが表示できるか' do
    4.times do |n|
      visit new_book_path
      fill_in 'メモ', with: @book.memo
      fill_in '題名', with: @book.title
      click_on '登録する'
    end
    visit books_url
    assert_selector 'span', text: '次'
  end

  test '本を更新できるか' do
    visit books_url
    click_on '編集', match: :first

    fill_in 'メモ', with: @book.memo
    fill_in '題名', with: @book.title
    click_on '更新する'

    assert_text '本が更新されました。'
    click_on '戻る'
  end

  test '本を削除できるか' do
    visit books_url
    page.accept_confirm do
      click_on '削除', match: :first
    end

    assert_text '本が削除されました。'
  end
end
