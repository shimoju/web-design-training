# Webデザイン課題 第3回
Twitter APIを使い、タイムラインを表示する簡単なTwitterアプリを作ります。

- 期限：?/?(水)まで
- 提出方法：hiroshi.shimoju@gmail.com にメール送信


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
[RubyInstaller](http://rubyinstaller.org/downloads/)から、
一番上にある最新版(10月現在では「Ruby 2.1.3」)をダウンロードしてください。

インストール手順は[このページ](http://www.ruby.or.jp/ja/tech/install/ruby/install_win.html)を見てください。
ここではバージョン1.9.3で説明されていますが、2.1.3でも同じです。

終わったら、すべてのプログラム→アクセサリ(Windows 8ならスタートボタンを右クリック)
からコマンド プロンプトを開いて、

```
ruby -v
```

と入力してEnterを押し、`ruby 2.1.3p242`と出ればOKです。

### Macの場合
まず、[Mac App StoreからXcodeをインストール](https://itunes.apple.com/jp/app/xcode/id497799835?mt=12)
してください。
(App Storeがない古いMacで、Xcodeも入っていない場合は相談してください)

次に、アプリケーション→ユーティリティ にある、ターミナルを開いて、

```
curl https://gist.githubusercontent.com/shimoju/74947a3e306256785271/raw/install-ruby.sh | bash
```

と入力してEnterを押し、指示に従いパスワードを入力してしばらく待ちます。

終わったら、

```
ruby -v
```

を実行し、`ruby 2.1.3p242`と出ればOKです。
