# 第3章：開発環境のセットアップ

**目安時間：6時間**

> **前提：** 第2章を読み終えていること（何をインストールしてはいけないか・何を管理すべきかを理解した上で進める）

> この章を終えると、VS Code・ターミナル・Git / GitHub・Gemini CLI がすべて使える状態になる。手順通りに進めれば詰まる箇所は少ないが、エラーが出たら Gemini に貼り付けて聞くのが最速。

---

## この章で学ぶこと

- VS Code をインストールして基本的な操作を覚える
- ターミナルの基本的なコマンドを使えるようにする
- Git をセットアップしてバージョン管理の基本を体験する
- GitHub にリポジトリを作ってコードを管理できるようにする
- Gemini CLI をインストールしてターミナルから Gemini を操作できるようにする

---

## 3-1. Visual Studio Code のインストールと基本設定

### インストール

[https://code.visualstudio.com/](https://code.visualstudio.com/) からダウンロードしてインストールする。

<!-- TODO: screenshot - VS Code ダウンロードページ -->

### 最低限やっておく設定

VS Code を開いたら、以下の2点だけ設定しておく。

**① 日本語化（任意）**

拡張機能（Extensions）から `Japanese Language Pack for Visual Studio Code` を検索してインストールする。

**② ターミナルの確認**

メニューの `Terminal > New Terminal` でターミナルが開くことを確認する。VS Code 内蔵のターミナルを使うことで、エディタとターミナルを行き来しなくてよくなる。

<!-- TODO: screenshot - VS Code 内蔵ターミナル -->

---

## 3-2. ターミナルの基本操作

ターミナルは「キーボードでコンピュータに命令を送る画面」。最初は怖く見えるが、使うコマンドは数個だけ覚えれば十分。

### よく使うコマンド

```bash
# 現在いるディレクトリを表示する
pwd

# ディレクトリの中身を表示する
ls

# ディレクトリを移動する
cd フォルダ名

# 一つ上のディレクトリに戻る
cd ..

# フォルダを作る
mkdir フォルダ名

# ファイルを作る（中身が空のファイル）
touch ファイル名
```

### 実際に試す

デスクトップに `practice` というフォルダを作って、その中に移動してみよう。

```bash
cd ~/Desktop
mkdir practice
cd practice
pwd
```

`pwd` で `/Users/自分のユーザー名/Desktop/practice` のようなパスが表示されれば成功。

---

## 3-3. Git のインストールと初期設定

### インストール確認

まず Git が入っているか確認する。

```bash
git --version
```

`git version 2.x.x` のように表示されれば OK。表示されない場合は以下からインストールする。

- **macOS**：`xcode-select --install` をターミナルで実行するか、[https://git-scm.com/](https://git-scm.com/) からダウンロード
- **Windows**：[https://git-scm.com/](https://git-scm.com/) からダウンロード

### 初期設定（必須）

Git を使う前に、コミット時に使う名前とメールアドレスを設定する。

```bash
git config --global user.name "自分の名前"
git config --global user.email "自分のメールアドレス"
```

設定が反映されているか確認。

```bash
git config --global --list
```

`user.name` と `user.email` が表示されれば完了。

---

## 3-4. GitHub アカウントの作成とリポジトリの作成

### アカウント作成

[https://github.com/](https://github.com/) にアクセスしてアカウントを作成する。すでに持っている場合はスキップ。

<!-- TODO: screenshot - GitHub サインアップ画面 -->

### リポジトリの作成

1. ログイン後、右上の `+` から `New repository` を選択
2. Repository name に `todo-app` と入力
3. `Public` または `Private` を選択（どちらでも可）
4. `Add a README file` にチェックを入れる
5. `Create repository` をクリック

<!-- TODO: screenshot - リポジトリ作成画面 -->

### SSH 接続の設定（推奨）

> **用語｜SSH（Secure Shell）：** ネットワーク越しに安全に通信するための仕組み。GitHubへの接続に使うことで、毎回パスワードを入力せずにプッシュ・プルができる。

GitHub との通信を SSH で行う設定をしておくと、毎回パスワードを入力しなくて済む。

```bash
# SSHキーを生成する（メールアドレスは自分のものに変更）
ssh-keygen -t ed25519 -C "自分のメールアドレス"
```

途中で保存先とパスフレーズを聞かれる。保存先はデフォルトのまま Enter、パスフレーズは空でも可。

```bash
# 生成した公開鍵を表示する
cat ~/.ssh/id_ed25519.pub
```

表示された文字列（`ssh-ed25519` から始まる1行）をコピーして、GitHub の `Settings > SSH and GPG keys > New SSH key` に貼り付ける。

<!-- TODO: screenshot - GitHub SSH keys 設定画面 -->

接続確認。

```bash
ssh -T git@github.com
```

`Hi ユーザー名! You've successfully authenticated` と表示されれば完了。

> SSH 設定はエラーが出やすい箇所。うまくいかない場合はエラーメッセージをそのままコピーして Gemini に貼り付けて聞こう。「このエラーの原因と解決方法を教えてください」で大抵解決できる。

---

## 3-5. 基本的な Git 操作

Git の基本的な流れは「変更を記録してリモート（GitHub）に送る」。

> **用語｜ステージング：** コミット（記録）する前に「この変更を記録対象に含める」と選択する操作。`git add` で行う。全変更を一度にコミットするのではなく、関連する変更だけをまとめてコミットできる。

### 基本コマンド

```bash
# リポジトリを初期化する（新規作成時）
git init

# リモートリポジトリをローカルにコピーする
git clone リポジトリのURL

# 変更したファイルをステージングする（コミット対象に追加）
git add ファイル名
git add .   # カレントディレクトリ以下すべて

# ステージングされた変更をコミットする（記録する）
git commit -m "変更内容のメッセージ"

# リモートリポジトリに送る
git push origin main

# 現在の状態を確認する
git status

# コミット履歴を確認する
git log --oneline
```

### 実際の流れ

```bash
# 1. GitHubからリポジトリをクローンする
git clone git@github.com:自分のユーザー名/todo-app.git

# 2. ディレクトリに移動
cd todo-app

# 3. ファイルを作る
touch index.html

# 4. 変更をステージング
git add index.html

# 5. コミット
git commit -m "最初のコミット"

# 6. プッシュ
git push origin main
```

GitHubのページを更新して `index.html` が追加されていれば成功。

---

## 3-6. `.gitignore` の書き方

第2章で学んだとおり、機密情報や不要なファイルはGitの管理対象から除外する。

### `.gitignore` ファイルを作る

リポジトリのルートに `.gitignore` ファイルを作成する。

```bash
touch .gitignore
```

VS Code で開いて、以下を記述する。

```bash
# 環境変数ファイル（認証情報が含まれる）
.env
.env.local
.env.*.local

# macOS が自動生成するファイル
.DS_Store

# Windows が自動生成するファイル
Thumbs.db

# エディタが生成するファイル
.vscode/settings.json

# 依存パッケージ（後で使う場合）
node_modules/
```

### 確認方法

`.env` ファイルを作って `git status` を実行し、`.env` が「Changes not staged for commit」に表示されないことを確認する。

```bash
touch .env
git status
```

`.gitignore` が正しく機能していれば、`.env` は一覧に表示されない。

---

## 3-7. Gemini CLI のインストールと認証設定

### インストール

Gemini CLI は Node.js 上で動作する。まず Node.js が入っているか確認する。

```bash
node --version
```

`v18.x.x` 以上が表示されれば OK。入っていない場合は [https://nodejs.org/](https://nodejs.org/) から LTS 版をインストールする。

次に Gemini CLI をインストールする。

```bash
npm install -g @google/gemini-cli
```

インストール確認。

```bash
gemini --version
```

<!-- TODO: バージョン番号は公式ドキュメントで確認 -->

### 認証設定

Gemini CLI を使うには Google アカウントでの認証が必要。

```bash
gemini auth login
```

ブラウザが開き、Google アカウントでのログインを求められる。Gemini Enterprise を利用している場合は、会社のGoogle Workspaceアカウントでログインする。

<!-- TODO: screenshot - ブラウザでの認証画面 -->

認証完了後、ターミナルに戻ると認証が完了している。

---

## 3-8. Gemini CLI を起動する

```bash
gemini
```

これだけで起動する。Web UI と同じように複数ターンの会話が続けられる。

```
> こんにちは
こんにちは！何かお手伝いできることはありますか？

> さっきの回答をもっと短くして
（前の会話の文脈を踏まえて回答する）
```

終了するには `Ctrl + C`。

> オプションやファイルの渡し方など、より高度な使い方は第5章で学ぶ。

---

## 3-9. Web UI（Google Workspace）と CLI の使い分け

どちらを使うかは、何をしたいかで決める。

| 用途 | 向いているツール | 理由 |
|---|---|---|
| 気軽に質問する | Web UI | ブラウザで開くだけで使える |
| ファイルを渡して処理させる | CLI | ファイルパスをそのまま渡せる |
| コードのレビューを依頼する | CLI | パイプでコードを渡しやすい |
| 長い会話を続ける | Web UI | 会話履歴が画面で見やすい |
| 繰り返し同じ操作をする | CLI | スクリプト化・自動化ができる |

どちらが優れているというものではない。状況に応じて使い分けることが重要。

---

## やってみよう

### ① VS Code でフォルダを開き、ターミナルを起動する

1. VS Code を起動する
2. `File > Open Folder` で `practice` フォルダを開く
3. `Terminal > New Terminal` でターミナルを開く
4. `pwd` を実行して現在地を確認する

---

### ② `git init` から `git push` まで一通り実行する

先ほど作った `practice` フォルダで、以下を順番に実行する。

```bash
# ファイルを作る
touch README.md

# Gitの初期化（すでにクローンした場合はスキップ）
git init

# 変更をステージング
git add README.md

# コミット
git commit -m "READMEを追加"

# GitHubにプッシュ
git push origin main
```

GitHubのページで `README.md` が追加されていることを確認する。

---

### ③ `.gitignore` に `.env` を追加してコミット対象から外れることを確認する

```bash
# .env ファイルを作る（ダミーの内容）
echo "API_KEY=dummy_key_12345" > .env

# .gitignore を作る
touch .gitignore
```

VS Code で `.gitignore` を開き、`.env` を追記する。

```bash
# git status で .env が表示されないことを確認
git status
```

`.env` が表示されなければ正しく除外されている。

---

### ④ Gemini CLI で最初のメッセージを送る

```bash
gemini "自己紹介してください"
```

レスポンスが返ってきたら動作確認完了。

---

## もっと深く知るために

### 公式ドキュメント

- [Gemini CLI 公式リポジトリ](https://github.com/google-gemini/gemini-cli)
- [Git 公式ドキュメント（日本語）](https://git-scm.com/book/ja/v2)
- [GitHub Docs](https://docs.github.com/ja)

### Gemini に聞いてみよう

```
Git の add・commit・push の違いを初心者向けに説明してください。
```

```
.gitignore に書くべきファイルのベストプラクティスを教えてください。
```

```
Gemini CLI でできることを一覧で教えてください。
```

### 次に調べるとよいキーワード

- `git branch 使い方`
- `git merge conflict 解決方法`
- `SSH GitHub 設定`
- `Node.js npm グローバルインストール`
