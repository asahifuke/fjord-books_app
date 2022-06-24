require 'rails_helper'

RSpec.describe "Reports", type: :system do
  fixtures :users
  # describe '行う作業' do
  #   it 'Railsアプリに reports（日報） の CRUD （一覧、個別、作成、編集、削除）の機能を追加する。'
  #   it 'books と reports それぞれにコメントがつけられるようにする。'
  #   it 'ポリモーフィック関連を使ってbookに付くコメントとreportに付くコメントを共通のコードで動くようにする。'
  # end

  describe '必須要件' do
    it 'reportsのCRUDを作る。入力項目はタイトルと本文だけで良い。created_atの日付を日報の投稿日とする' do
      sign_in users(:alice)
      visit reports_path
      expect(page).to have_content '日報'
    end

    # it '日報を更新・削除できるのはその日報を投稿した本人のみ（本のCRUDは特に制限なし）'
    # it '本と日報の各詳細画面からコメントを投稿できるようにする。'
    # it '投稿したコメントは本と日報の各詳細画面から確認できる。投稿した内容に加えて、投稿したユーザーの名前（未入力ならメアド）と投稿日時も表示する'
    # it '本と日報の各詳細画面でコメントが投稿できている様子をスクショする'
    # it 'rubocopをパスさせる（要スクリーンショット）'
  end

  # describe '注意点やヒントなど' do
  #   it 'form_withはURLを生成するのにpolymorphic_pathを使っています。polymorphic_pathで思い通りのURLが生成できるかどうか試してみよう。'
  #   it 'コメント入力フォームはHTML5の必須チェック機能を使うと、コメント未入力で投稿された時の考慮が不要となる'
  #   it 'scaffoldの自動生成機能を使う場合は、JSONレスポンスのように使う予定のない機能は削除した状態でコミットする'
  #   it '本や日報が削除されたらコメントはどうなるか？ユーザーが退会したらコメントはどうなるか？を検討する'
  #   it '日報の投稿日やコメントの投稿日時はタイムゾーンの扱いに注意する（日本時間じゃないかも？）'
  #   it 'i18nの機能を使って日本語表示する（英語化は考慮不要）'
  # end

  # describe '歓迎要件' do
  #   it 'コメントが1件もない場合はその旨を画面に表示する'
  #   it 'HTML5の必須チェックが効かない場合を考慮して、バリデーションエラー時のレスポンスも返せるようにする'
  #   it 'コメントの編集と削除ができるようにする'
  # end
end
