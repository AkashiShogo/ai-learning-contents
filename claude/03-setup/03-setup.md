# 第3章：開発環境のセットアップ（Claude トラック）

**目安時間：6時間**

> **前提：** 第2章を読み終えていること（何をAIに渡してはいけないか・AIにどこまで許可するかの考え方を理解した上で進める）

> この章を終えると、VS Code・ターミナル・Git / GitHub・Claude Code がすべて使える状態になる。手順通りに進めれば詰まる箇所は少ないが、エラーが出たら Claude に貼り付けて聞くのが最速。

---

## この章で学ぶこと

- VS Code をインストールして基本的な操作を覚える
- ターミナルの基本的なコマンドを使えるようにする
- Git をセットアップしてバージョン管理の基本を体験する
- GitHub にリポジトリを作ってコードを管理できるようにする
- Claude Code をインストールしてターミナルからAIと開発できるようにする
- Claude Code の「許可プロンプト」の付き合い方を身につける

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

メニューの `Terminal > New Terminal` でターミナルが開くことを確認する。VS Code 内蔵のターミナルを使うことで、エディタとターミナルを行き来しなくてよくなる。Claude Code もこのターミナル内で動かせる。

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

> SSH 設定はエラーが出やすい箇所。うまくいかない場合はエラーメッセージをそのままコピーして Claude（claude.ai）に貼り付けて聞こう。「このエラーの原因と解決方法を教えてください」で大抵解決できる。

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

# 変更内容（差分）を確認する
git diff

# コミット履歴を確認する
git log --oneline
```

### Claude トラックでは `git diff` が特に重要

Claude Code はファイルを直接書き換える。**AIが何を変更したかを確認する手段が `git diff`。** このコマンドはこの先のすべての章で使うので、今のうちに手に馴染ませておく。

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

## 3-7. Claude Code のインストールと認証設定

### Claude Code とは（あらためて）

Claude Code は、ターミナルで動く **エージェント型** のコーディングツール。チャットのように会話できるだけでなく、こちらの依頼に応じて **ファイルを読む・書き換える・コマンドを実行する** ところまでAI自身が行う。

人間の役割は「コードのコピペ係」ではなく、**指示を出して、操作を許可して、結果をレビューする側** になる。

### 利用に必要なもの

Claude Code を使うには、次のいずれかが必要。

- **Claude の有料プラン**（Pro / Max。会社契約の Team / Enterprise でも可）
- **Anthropic の API アカウント**（従量課金）

このコンテンツでは Claude アカウント（サブスクリプション）でのログインを前提に進める。どのプランで使えるかの最新情報は公式ページで確認すること。

### インストール

公式のインストールスクリプトを使う。

```bash
# macOS / Linux / WSL
curl -fsSL https://claude.ai/install.sh | bash
```

```powershell
# Windows (PowerShell)
irm https://claude.ai/install.ps1 | iex
```

> インストール方法は更新されることがある。エラーが出る場合や Windows ネイティブ環境の詳細は、[公式ドキュメントのセットアップページ](https://code.claude.com/docs) で最新の手順を確認する。Node.js が入っていれば `npm install -g @anthropic-ai/claude-code` でも導入できる。

インストール確認。

```bash
claude --version
```

バージョン番号が表示されれば OK。

### 認証設定

プロジェクトフォルダに移動してから起動する。

```bash
cd ~/Desktop/practice
claude
```

初回起動時にログイン方法を聞かれる。**Claude アカウント（サブスクリプション）でのログイン** を選び、ブラウザで認証を完了させる。

<!-- TODO: screenshot - 初回起動時のログイン画面 -->

> 会社で API キーが配布されている場合は Console（API）でのログインを選ぶ。どちらを選んだかで課金のされ方が変わるので、会社利用の場合は管理者の指示に従うこと。

---

## 3-8. Claude Code を起動して最初の会話をする

### 対話モード

```bash
claude
```

起動すると入力欄が表示され、Web UI と同じように会話できる。

```
> こんにちは。あなたに何ができるか教えてください
（Claude Code ができることの説明が返ってくる）
```

終了するには `/exit` と入力するか `Ctrl + C` を2回。

### 最初に覚えるスラッシュコマンド

入力欄で `/` から始まるコマンドを打つと、ツール自体の操作ができる。まずはこの3つだけ覚える。

| コマンド | 役割 |
|---|---|
| `/help` | 使い方とコマンド一覧を表示する |
| `/clear` | 会話履歴をリセットして新しい会話を始める |
| `/exit` | 終了する |

### 一回きりの質問（ワンショット実行）

対話モードに入らず、1つの質問だけ投げることもできる。

```bash
claude -p "gitのcommitとpushの違いを1行で説明して"
```

`-p`（print）オプションで質問を渡すと、回答を表示して終了する。パイプと組み合わせてファイルの内容を渡すこともできる。

```bash
cat index.html | claude -p "このHTMLに問題がないか確認して"
```

### 許可プロンプトを体験する

Claude Code の最大の特徴を最初に体験しておく。対話モードでこう頼んでみよう。

```
> hello.txt というファイルを作って、中身に「Hello, Claude Code!」と書いてください
```

すると、Claude Code は**実行前に許可を求めてくる**。

```
Claude wants to create hello.txt
  Do you want to proceed?
```

ここで第2章2-7の話がつながる。**この確認が、AIの操作に対する最後の防衛線。** 何をしようとしているかを読んでから許可する癖を、最初の1回目からつける。

許可するとファイルが作られる。`ls` と `cat hello.txt` で本当に作られたことを確認しよう。

> **この章の時点でのルール：** 許可プロンプトは毎回内容を読んでから承認する。「常に許可」系の選択肢は、第5章で許可設定の管理を学ぶまで使わない。

---

## 3-9. Web UI（claude.ai）と Claude Code の使い分け

どちらを使うかは、何をしたいかで決める。

| 用途 | 向いているツール | 理由 |
|---|---|---|
| 気軽に質問する・調べる | Web UI（claude.ai） | ブラウザで開くだけで使える |
| 概念の学習・壁打ち | Web UI | 会話履歴が画面で見やすい |
| プロジェクトのコードを触る作業 | Claude Code | ファイルの読み書きをAIが直接行える |
| エラーの調査と修正 | Claude Code | エラーを見ながらその場で直せる |
| Git操作を含む開発作業 | Claude Code | コマンド実行まで一気通貫でできる |

ざっくり言えば、**「聞く」は Web UI、「作業する」は Claude Code**。どちらが優れているというものではなく、状況に応じて使い分ける。

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

### ④ Claude Code でファイルを作らせて、許可プロンプトを体験する

3-8 の手順で `hello.txt` を作らせる。許可プロンプトの内容を**声に出して読んでから**承認する（最初は大げさなくらいでいい）。

作成後、ターミナルで実物を確認する。

```bash
cat hello.txt
```

---

### ⑤ Claude Code にファイルを変更させて、diff で確認する

対話モードで頼む。

```
> hello.txt の内容を「Hello, World!」に書き換えてください
```

許可して変更されたら、**Claude の報告を鵜呑みにせず**、自分で差分を確認する。

```bash
cat hello.txt
```

Gitで管理しているフォルダなら `git diff` でも確認できる。**「AIが変更 → 自分で差分確認」** はこの先ずっと使う基本動作。ここで体に入れる。

---

### ⑥ エラーをAIに解決させる体験をする

セットアップ中に何かエラーに遭遇していたら、それが教材になる。エラーが出ていなければ、わざと存在しないコマンドを実行してみる。

```bash
gitt status
```

出てきたエラーメッセージをそのまま Claude Code に貼り付けて聞く。

```
> ターミナルで以下のエラーが出ました。原因と解決方法を教えてください。
[エラーメッセージ]
```

「エラーメッセージは怖いものではなく、AIに渡せば解決の手がかりになる情報」という感覚をここで作っておく。

---

## 理解度チェック

1. `git add`・`git commit`・`git push` のそれぞれの役割を1行ずつで説明できる？（→ 3-5）
2. Claudeトラックで `git diff` が特に重要なのはなぜ？（→ 3-5）
3. `.gitignore` に書いたファイルはどうなる？`.env` を書く理由は？（→ 3-6）
4. Claude Code が「チャットAI」と違う点は？人間の役割はどう変わる？（→ 3-7）
5. 許可プロンプトが表示されたとき、承認する前に確認すべきことは？（→ 3-8）
6. Web UI（claude.ai）と Claude Code の使い分けの基準を自分の言葉で説明できる？（→ 3-9）

---

## もっと深く知るために

### 公式ドキュメント

- [Claude Code 公式ドキュメント](https://code.claude.com/docs)
- [Git 公式ドキュメント（日本語）](https://git-scm.com/book/ja/v2)
- [GitHub Docs](https://docs.github.com/ja)

### Claude に聞いてみよう

```
Git の add・commit・push の違いを初心者向けに説明してください。
```

```
.gitignore に書くべきファイルのベストプラクティスを教えてください。
```

Claude Code 自身にも聞ける。

```bash
claude -p "Claude Code でできることを初心者向けに一覧で教えてください"
```

### 次に調べるとよいキーワード

- `git branch 使い方`
- `git diff 見方`
- `SSH GitHub 設定`
- `Claude Code スラッシュコマンド`
