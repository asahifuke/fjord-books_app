# frozen_string_literal: true

require 'application_system_test_case'

class BooksTest < ApplicationSystemTestCase
  BOOKS_JA_PATH = '/books?locale=ja'
  BOOKS_EN_PATH = '/books?locale=en'

  setup do
    @book = books(:one)
  end

  test '英語の一覧画面にアクセスした時' do
    visit BOOKS_EN_PATH
    assert_selector 'h1', text: 'Books'
  end

  test '日本語の一覧画面にアクセスした時' do
    visit BOOKS_JA_PATH
    assert_selector 'h1', text: '書籍'
    assert_selector 'a',  text: '詳細'
    assert_selector 'a',  text: '編集'
    assert_selector 'a',  text: '削除'
    assert_selector 'a',  text: '新規書籍'
  end

  test '日本語の新規作成画面にアクセスした時' do
    visit '/books/new?locale=ja'
    assert_selector 'h1',    text: '新規書籍'
    assert_selector 'a',     text: '戻る'
    assert_selector 'label', text: 'タイトル'
    assert_selector 'label', text: 'メモ'
    assert_selector 'label', text: '著者'
    assert_selector 'label', text: '写真'
  end

  test '日本語の詳細画面にアクセスした時' do
    visit "/books/#{@book.id}?locale=ja"
    assert_selector 'strong', text: 'タイトル'
    assert_selector 'a',      text: '編集'
    assert_selector 'a',      text: '戻る'
  end

  test '日本語の編集画面にアクセスした時' do
    visit "/books/#{@book.id}/edit?locale=ja"
    assert_selector 'h1', text: '本の編集'
    assert_selector 'a',  text: '詳細'
    assert_selector 'a',  text: '戻る'
  end

  test '書籍の新規作成' do
    visit BOOKS_EN_PATH
    click_on 'New Book'

    fill_in 'Memo',  with: @book.memo
    fill_in 'Title', with: @book.title
    click_on 'Create Book'

    assert_text 'Book was successfully created'
    click_on 'Back'
  end

  test '英語の画面で書籍の更新' do
    visit BOOKS_EN_PATH
    click_on 'Edit', match: :first

    fill_in 'Memo',  with: @book.memo
    fill_in 'Title', with: @book.title
    click_on 'Update Book'

    assert_text 'Book was successfully updated'
    click_on 'Back'
  end

  test '日本語の画面で書籍の更新' do
    visit BOOKS_JA_PATH
    click_on '編集', match: :first

    fill_in 'メモ',  with: @book.memo
    fill_in 'タイトル', with: @book.title
    click_on '書籍の更新'

    assert_text '書籍が正常に更新されました。'
    click_on '戻る'
  end

  test '英語の画面で書籍の削除' do
    visit BOOKS_EN_PATH
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Book was successfully destroyed'
  end

  test '日本語の画面で書籍の削除' do
    visit BOOKS_JA_PATH
    page.accept_confirm do
      click_on '削除', match: :first
    end

    assert_text '書籍を正常に削除しました。'
  end
end
