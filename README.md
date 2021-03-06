# BuzzSeed
<img src="https://user-images.githubusercontent.com/72225170/122899983-45cc6180-d387-11eb-9774-f89004b3d362.jpg" width=35%>

## サイト概要
お題画像に対して心を動かすヒトコトをいれる大喜利アプリです。 
  
GoogleCloud VisionAPIのLABEL_DETECTIONが画像から抽出する特徴と、  
人間が同じ画像を見た際の一般的な第一印象には微妙に差があるという点に着目し、  
抽出される特徴を画像に対する別視点のベクトルとして、  
ヒトコト投稿の一助となるよう工夫しております。  

以下の機能を導入しています。

### 利用者側から見える機能
- お題（画像）、ヒトコト、コメント、いいねの基本的なCRUD機能
- 画像投稿、編集時のプレビュー機能
- レスポンシブ対応（PC,スマホサイズで対応）
- 通知機能
- ユーザー検索機能（ransack）
- Twitter専用アカウントor自身のアカウントでのマイページシェア機能（TwitterAPI）
- 専用のTwitterアカウントから毎朝アプリ内のデータを自動でツイート（Wheneverを使用したバッチ処理）
- お題から特徴を抽出し、お題画像に自動でラベル付け（GoogleLABEL_DETECTION API）
- お題から抽出した特徴を翻訳して出力（GoogleTransrateAPI）
- チュートリアル機能
- ユーザーフォロー機能
- ヒトコト、お題それぞれのランキング表示（いいね及び、題材にされた数順）
- お問い合わせ機能（Googleフォームを利用）

### セキュリティ面含め、その他の機能
- 管理者側からの投稿の削除、アカウント凍結機能
- ユーザー、管理者認証（Device使用）
- メール認証
- ゲストユーザーの投稿を定期的に自動削除（Wheneverを使用したバッチ処理）
- 専用のエラー画面を作りエラー時に遷移させる
- RSpecを用いた単体および結合テスト計48項目（model,request）
- 環境変数を利用し、Gitへ反映させる情報の管理（dotenv-rails）
- rubocopを利用
- AWSを使用したデプロイ(EC2,RDS)
- ドメイン取得
- HTTPS化
- GitHub Actionsを使用した自動デプロイ

### サイトテーマ
- さらっと覗いてクスっと笑える、日常に新しい視点を手に入れる。
- 心を動かすヒトコトや、ヒトコトをつけたくなる画像（フリ）はどんなものかを学び、生活に取り入れる。

### テーマを選んだ理由
下記の自身の考えを形にしたく選定しました。
+ なんでもない日常やネガティブな場面でも捉え方で面白くなることを伝えたい
+ ツッコミ気質になっている人に対して、リスクなく小さなチャレンジができる環境を作り日常をより楽しくしたい
+ 面白い言い回しだけでなく、どのようなフリが答えやすいかを考える癖をつけることにより、お互いの美味しさを尊重し合う健全な人間関係を広めたい

### ターゲットユーザ
- 笑いたい人
- 笑わせたい人
- より良い人間関係を求めている人

### 主な利用シーン
- 日常生活の空き時間（電車の乗っている間、テレビCMの間など）に回答一覧を見て楽しむ。
- 印象深い写真が取れた時にお題として投稿し、他ユーザーのリアクションで楽しむ。

## 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9

## 使用素材
- https://ja.cooltext.com/
- https://pixabay.com/ja/
- https://www.pakutaso.com/
- https://gratisography.com/
