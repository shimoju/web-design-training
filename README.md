# Webデザイン課題 第2回
HTML・CSS・JavaScript/jQueryを使って、写真ギャラリーサイトを作ってください。

今回の見本はスクリーンショットで配布するためソースは見れません。1から自力で作っていただきます。

- 期限：8/20(水)まで
- 提出方法：hiroshi.shimoju@gmail.com にメール送信


## 完成見本
まず実物を見たほうがわかりやすいと思うので、見本を見てください。

https://www.youtube.com/watch?v=Fem5O-iAhKY

このように、クリックすると拡大して表示される写真リストと、
イメージスライダーを使って写真が流れていくギャラリーを作ります。

![課題2 完成見本](https://raw.githubusercontent.com/shimoju/web-design-training/ex2/sample.png)


## JavaScript・jQueryについて
### JavaScript = 動く
JavaScriptはプログラミング言語の一つで、Webで使うために作られました。
HTML/CSSだけではできないアニメーションをつけたりなど、リッチで動きのあるページを作れます。

GmailやTwitterなど、現在の高機能なWebサービスはすべてJavaScriptを使って実現されています。

### jQuery = 便利なやつ
JavaScriptは意外と低機能なので、土橋ゼミがJavaScriptをそのまま書こうとするとつらいことになります。
JavaScriptを便利にするために作られたのがjQueryです。

便利すぎるため、[全サイトの半数以上](http://www.publickey1.jp/blog/13/jqueryweb55w3techs.html)、
[日本の企業サイト(日経225掲載企業)では9割近く](http://iwb.jp/dont-use-jquery-latest-js/)
がjQueryを使っています。

とりあえずjQueryは便利、これを使えと思っておけば間違いありません。

### jQueryライブラリ = ありものを使う
jQueryは便利なので、これをもとに作られたライブラリ(便利な機能をひとまとまりにしたもの)が沢山あります。
例えば今回の課題で使うイメージスライダーや、パララックスエフェクト、音楽関係もあります。

http://coliss.com/articles/build-websites/operation/javascript/100-jquery-plugins-2013-best.html

少し検索すれば便利なものはすぐ見つかるので、「ありものを使う」を徹底してください。

### 読み込み方法
JavaScriptはHTMLから`script`タグで読み込んで使用します。「パス」の指定の仕方はCSSや画像と同じです。
書く場所は通常は`head`タグ内の最後です。

```html
<!-- jsフォルダの中にjquery.jsがある場合 -->
<script src="js/jquery.js"></script>
```

JavaScriptはネットから取り込んで使用することもできます。

jQueryは使用率が高いので、広く使っていいですよと公開しているサービスがいくつかあります。
これをCDN(Contents Delivery Network)といいます。
自分でいちいちjQueryをダウンロードして配置する必要がないので、CDNはよく利用されています。

```html
<!-- jsDelivrが提供するCDNから読み込む -->
<script src="https://cdn.jsdelivr.net/jquery/2.1.1/jquery.min.js"></script>
<!-- Googleが提供するCDNから読み込む -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
```

テンプレートでは既にCDNからjQueryを読み込むようにしているので、詳しくはテンプレートを見てください。


## 素材をダウンロードする
HTML素材(テンプレート)はここからダウンロードしてください。

https://github.com/shimoju/web-design-training/archive/ex2.zip

- フォルダ構成は前回と同じですが、新たにJavaScriptを入れるための「js」フォルダが追加されています。
- 展開してできたフォルダの名前は、**自分の名前(漢字)**に変更してください。
- HTMLのtitleタグは「ここにタイトルを書きます」となっていますが、ここも**自分の名前(漢字)**に変更してください。
- 提出はこのフォルダをzipで圧縮し、それをメールに添付してください。

### フォルダ構成
- css/
    - main.css : このファイルにCSSを書きます
- img/
    - このフォルダに画像を入れます
- js/
    - main.js : このファイルにJavaScriptを書きます
- index.html : このファイルにHTMLを書きます


## 課題
### 1. 写真を10枚以上集める
写真ギャラリーサイトなので、まず画像を集めてください。画像は前回同様imgフォルダに入れてください。
集める画像はバラバラではなく、あるテーマに沿ったものとしてください。(好きな車、アーティスト、猫など)

サイズは大きすぎ/小さすぎなければ何でも構いませんが、並べた時やスライダーを使った時にずれないようにするため、
縦横比は同じものにすることが望ましいです。必要であればリサイズ・切り抜きをしてください。
(4:3か16:9が一般的で、CDジャケット等を使うなら正方形もありでしょう)

### 2. 普通に画像を表示する
index.htmlを開き、まずはimgタグを使って普通に画像を表示します。
第1回でやったfloatなどを使って綺麗に並べてください。

本題は次なので、この時点でそこまで凝ったデザインにする必要はありません。

### 3. jQuery画像拡大プラグイン(Lightbox)を使う
画像をクリックするとふわっと拡大されて表示されるページを見たことがあると思います。
これを実現するのがLightboxです。

定番なので派生バージョンがいくつもありますが、今回は[Nivo Lightbox](http://demo.dev7studios.com/nivo-lightbox/)を使います。
ここからダウンロードしてください。

https://github.com/gilbitron/Nivo-Lightbox/releases

展開したフォルダの中の、

- `nivo-lightbox.min.js`を課題のjsフォルダに、
- `nivo-lightbox.css`と`themes`フォルダを課題のcssフォルダに、

それぞれコピーします。

index.htmlを開き、Nivo Lightboxを読み込みます。

```html
<title>ここにタイトルを書きます</title>

<!-- Nivo Lightbox CSS を読み込む -->
<link rel="stylesheet" href="css/nivo-lightbox.css">
<link rel="stylesheet" href="css/themes/default/default.css">

<!-- 自分で書いたCSS -->
<link rel="stylesheet" href="css/main.css">
<!-- JavaScript -->
<!-- jQuery (CDNから読み込み) -->
<script src="https://cdn.jsdelivr.net/jquery/2.1.1/jquery.min.js"></script>
<!-- jQueryライブラリはここ -->

<!-- Nivo Lightbox JavaScript を読み込む -->
<script src="js/nivo-lightbox.min.js"></script>

<!-- 自分で書いたJavaScript -->
<script src="js/main.js"></script>
<!-- /JavaScript -->
```

CSSもJavaScriptも上から順に読み込まれるので、必要な物が上にくるようにします。
jQueryプラグインはjQueryが必要なので、JavaScriptはjQuery→jQueryプラグイン→自分で書いたもの
になるようにします。

読み込むだけでは何も動かないので、JavaScriptを追加して実際に動くようにします。

jsフォルダのmain.jsを開き、以下を追加します。

```js
$(function() {
  $('a').nivoLightbox();
});
```

最後に、HTMLのimgタグをリンクの形にします。

```html
<!-- これを -->
<img src="img/1.jpg">
<!-- こうする -->
<a href="img/1.jpg"><img src="img/1.jpg"></a>
```

画像をクリックして、見事拡大表示されれば無事Lightboxが導入できました。
ページ内でふわっと表示されず単に画像が表示されてしまった場合、
どこかが間違っているのでもう一度確認してください。

### 4. jQueryスライダープラグインを使う
写真がすっと流れていくあれはスライダーやカルーセルと呼ばれています。

スライダープラグインは自分で導入してもらいます。
「[jquery スライダー|カルーセル](https://www.google.co.jp/#q=jquery+%E3%82%B9%E3%83%A9%E3%82%A4%E3%83%80%E3%83%BC%7C%E3%82%AB%E3%83%AB%E3%83%BC%E3%82%BB%E3%83%AB&tbs=qdr:y)」
などで検索し、好きなjQueryスライダープラグインをダウンロードしてください。

マニュアルが英語でも検索すればすぐに日本語資料は見つかるので、Lightboxの例を参考に自分で頑張ってみてください。

### 5. デザインする
写真ギャラリーなのでそこまでデザインするものはありませんが、
それでも文字色や背景色、写真の枠(img要素のborder)などデザイン要素はあります。

特に条件はつけません。第1回のレビューに書いた通り、テーマに沿ったデザインを心がけてください。

- クールな外車の写真→背景色は黒系に、タイトルを英語の細めフォントに、写真は角丸にはしない
- かわいい猫の写真→背景色をベージュなど暖色に、写真に太めのボーダーをつけて角丸にする

とかそんな感じで。


## 注意事項
### HTMLとCSS、JavaScriptは必ず別ファイルに分ける
配布したテンプレートに従って作れば問題はありません。

### ブラウザはGoogle Chromeで
通常はいくつかのブラウザで確認をしますが、今回は課題のため環境を統一したいので、Chromeのみを使用するものとします。


## 補足
### 開発者ツールを活用する
ページ上で右クリックして「要素の検証」をクリックすると開発者ツールが表示されます。
ちょっと慣れが必要ですが、覚えるとCSS編集が凄くしやすくなります。

### わからなければとにかく検索。1年以内でぐぐれ
HTML・CSSに限らずコンピュータ関係は変化が激しいので、普通に検索すると古い情報にあたってしまいがちです。

知ってる人も多いと思いますが、検索ツール→期間指定なし→1年以内 で検索すると楽です。

### 参考サイト
タグやCSSの辞典は↓が便利です。

- [HTML5リファレンス](http://www.htmq.com/html5/index.shtml)
- [CSSリファレンス](http://www.htmq.com/style/index.shtml)


## 連絡先
質問等はサイボウズの掲示板にお願いします。個人的に連絡したい場合はメールかTwitterまで。

hiroshi.shimoju@gmail.com

https://twitter.com/hshimoju
