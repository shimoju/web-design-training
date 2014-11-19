# Webデザイン課題 第3回
Twitter APIを使い、タイムラインを表示する簡単なTwitterアプリを作ります。

- 期限：11/19(水)まで
- 提出方法：hiroshi.shimoju@gmail.com にメール送信

作るといってもアプリは既にできていて、
皆さんはインストールして使ってみるというところをやります。

- 「API」について知る
- Twitterアプリを作る流れを知る
- ターミナル(コマンドプロンプト)に触れる
- プログラミング言語Rubyを使ってみる

ことが主な課題となります。課題自体は簡単ですが準備作業に結構時間がかかります。
ここはあまり楽しくないしエラーが起こると面倒になるので、
やってみてわからなければ気軽に質問してください。


## 「API」とは
ゼミのプロジェクトをやっていると、TwitterやFacebook、YouTubeなど、
既にあるサービスからデータを持ってきて利用したい場面はよくあると思います。

しかし勝手にデータを取ってくると著作権違反になってしまったり、
サービスに負荷をかける迷惑行為とされ利用規約違反になったりする恐れがあります。

ここで役立つのがAPIです。APIとはApplication Programming Interfaceの略ですが、
ごく簡単に言えば「データの取得や書き込みについての方法、ルール」のことです。

「APIが公開されている」というのは、**「この方法とルールに従うならデータを取ってきて使ってもいいですよ」
と公式に許可されている**、ということになります。

つまりAPIが公開されていれば、安心してデータを取得してサービス開発に利用できるということです。

様々なサービスがAPIを公開しています。どんなAPIがあるかは以下の記事にまとめられています。

- [【2014年度版】すべてのビジネスマンに役立つAPI一覧](http://keiei.freee.co.jp/2014/07/10/api/)
- [日本の全エンジニアに捧ぐ！現在公開されているAPI一覧【2013年版】](http://www.find-job.net/startup/api-2013)


## Twitter APIとTwitterアプリについて
TwitterももちろんAPIを公開しています。Twitter APIは登録制となっていて、
データを取得するにはTwitterのデベロッパーサイトに登録すると貰えるキー
(パスワードのようなもの)を使って認証する必要があります。

登録するには以下のページを開き、ログインします。
(普段使っているアカウントで大丈夫です。
そういえばTwitterをやっていない方がいるかもしれないのを考えていませんでしたが、
まあいないだろうしもしやってなければこの機会に登録してください)

https://apps.twitter.com/

手順は[アプリケーションの登録 - Twitter APIの使い方](http://syncer.jp/twitter-api-create-application)
を見てください。

Callback URLには以下を入力してください。

```
http://127.0.0.1/auth/twitter/callback
```

アプリが登録できたら「Keys and Access Tokens」をクリックし、
「Consumer Key (API Key)」と「Consumer Secret (API Secret)」を確認します。

これが認証に使うキー(≒IDとパスワード)です。これを後で使います。


## Rubyについて
今回はTwitterアプリを作るのに
[Ruby](https://www.ruby-lang.org/ja/)というプログラミング言語を使います。

Rubyは様々な用途に使えるプログラミング言語ですが、現在は特にWebアプリを作るのによく使われています。
代表例はクックパッド、食べログ、SoundCloud、初期のTwitter(今は別の言語)、GitHubなどです。

Webアプリでよく使われている言語には他にPHPもあります。
この言語で作られているアプリはブログソフトの[WordPress](https://ja.wordpress.org/)や、
Wikipediaで使われている[MediaWiki](http://www.mediawiki.org/wiki/MediaWiki/ja)など数多くあります。

ユーザーも一番多いのでできればPHPにしたいところですが、
自分がPHPを使えないので今回はRubyにしました。次回の課題はPHPにする予定です。


## Rubyをインストールする
ではRubyをインストールし、使えるようにします。
ここで時間を食うのは無駄なので、エラーが出たときは連絡してください。

### Windowsの場合
インストール手順は以下の記事に書いたので、こちらを参照してください。

http://qiita.com/shimoju/items/41035b213ad0ac3a979e

### Macの場合
まず、[Mac App StoreからXcodeをインストール](https://itunes.apple.com/jp/app/xcode/id497799835?mt=12)
してください。
(App Storeがない古いMacで、Xcodeも入っていない場合は相談してください)

次に、アプリケーション→ユーティリティ にある、ターミナルを開いて、

```
curl https://gist.githubusercontent.com/shimoju/74947a3e306256785271/raw/install-ruby.sh | bash
```

と入力してEnterを押し、指示に従いパスワードを入力してしばらく待ちます。[(スクリプトの内容)](https://gist.github.com/shimoju/74947a3e306256785271)


終わったら、

```
ruby -v
```

を実行し、`ruby 2.1.4p265`と出ればOKです。
(その時々の最新版なので、これより新しければ問題ありません)


## 課題をセットアップする
課題はここからダウンロードします。

https://github.com/shimoju/web-design-training/archive/ex3.zip

展開したら、ターミナル(Windowsはコマンドプロンプト、以下同様)を開き、そのフォルダに移動します。

デスクトップに展開した場合、

```
cd Desktop/web-design-training-ex3
```

となります。

### 必要なライブラリをインストールする
Bundlerというツールを使って必要なものをインストールします。
まずBundler自体をインストールします。

```
gem install bundler
```

Windowsで「セキュリティの警告」が出てきたら「アクセスを許可」してください。

次に

```
bundle install
```

を実行します。少し時間がかかります。

### APIキーを設定する
先ほど作成したTwitterアプリの「Keys and Access Tokens」にアクセスし、
Consumer Key (API Key)、Consumer Secret (API Secret)をコピーします。

課題の`app.rb`をテキストエディタで開いて、10、11行目に貼り付けます。
(Windowsの場合、「メモ帳」で開くと改行が反映されずうまくいかないので、
Sublime Textなどのプログラミング用テキストエディタで開いてください)

プログラミング入門などでやったと思いますが、「文字列」なのでクォーテーション（`'`または`"`）で囲みます。
以下のようになればOKです。

```ruby
# ここを変更する
twitter_api_key = 'JPuJ4TVLR9FNu6FLpq9HwxQsO'
twitter_api_secret = 'zhr7GLhj79yqup5x09u3oouF9ZLAzJSsXrmS7uDnLTjvcqNEfl'
```

### アプリを起動する
```
foreman start
```

を実行するとアプリが立ち上がります。

ブラウザで「[http://localhost:5000/](http://localhost:5000/)」にアクセスして、
「ログイン」と表示されていれば成功です。

「ログイン」を押してTwitterに飛び、「連携アプリを認証」すると自分のタイムラインが表示されます。
ここでエラーが出るならAPIキーの設定にミスがあるので確認してください。

アプリを終了するにはターミナルで`Ctrl+C`を押します。
Windowsでは「バッチ ジョブを終了しますか (Y/N)?」と聞かれるので、yを押してください。


## 課題
上の準備作業をするのは初回だけです。以降は

1. ターミナルを開く
2. `cd`で課題のフォルダに移動
3. `foreman start`を実行してアプリを起動
4. [http://localhost:5000/](http://localhost:5000/) にアクセス

すればアプリが動きます。

課題の本題は以下です。

### 1. Twitterウィジェットを導入する
ページ内にツイートボタンやTwitterのタイムラインを表示しているサイトはよくありますが、
これはTwitterウィジェットを使用しています。

- [埋め込みタイムライン](https://dev.twitter.com/ja/web/embedded-timelines)
- [埋め込みツイート](https://dev.twitter.com/ja/web/embedded-tweets)

ウィジェットを使用するために必要なJavaScriptが`widgets.js`で、以下のようにして読み込みます。

```html
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
```

`views/layout.erb`にこれを追加すれば、ツイートが綺麗にデザインされて表示されます。

```html
<head>
  <meta charset="utf-8">
  <title>Webデザイン課題 第3回</title>
  <link rel="stylesheet" href="css/main.css">
  <!-- JavaScript -->
  <!-- asyncがついているので一番上に追加 -->
  <script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
  <script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
  <script src="js/main.js"></script>
</head>
```

### 2. デザインする(やりたい人は)
準備に時間がかかると思うので今回はデザインは課題にしませんが、余裕がある人はデザインしてみてください。

Twitterウィジェットは使ったままでもいいですし、1からデザインしたいなら外しても構いません。

## 提出方法
今回はデザインはしないので、自分のパソコンでアプリを動かせたら課題完了として、
スクリーンショットで提出とします。

Twitter ウィジェットが導入された、またはデザインしたタイムラインのページをスクリーンショットして、
メールで送ってください。

デザインした人でファイルを見てもらいたい人はzipファイルで送ってください。
