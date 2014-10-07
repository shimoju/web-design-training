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
