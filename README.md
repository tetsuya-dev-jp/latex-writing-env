# latex-writing-env

`WSL2 + Docker Engine + VSCode` で使う、日本語 LaTeX 執筆環境です。

編集はホスト側の VSCode で行い、`build` と `format` と `lint` は Docker コンテナ内で実行します。

## 必要環境

- WSL2
- Docker Engine
- VSCode

## 初回セットアップ

```bash
make init
```

## 主要コマンド

```bash
make build FILE=documents/example-paper/main.tex
make lint FILE=documents/example-paper/main.tex
make lint-fix FILE=documents/example-paper/main.tex
make format FILE=documents/example-paper/main.tex
make clean
```

## VSCode での使い方

- 推奨拡張をインストールします。
- `Ctrl+Alt+B` でも `LaTeX Workshop` からこのリポジトリの `make build` が呼ばれます。
- 保存時の自動 format / build を使いたい場合は `Run On Save` 拡張を有効にします。
- PDF は VSCode のタブ内でプレビューします。

## 既存ルールで手動追加する

1. `documents/` 配下に新しいディレクトリを作ります。
2. ルート `main.tex` と必要な章ファイルを配置します。
3. 必要なら `refs.bib` など関連ファイルを配置します。
4. `make build FILE=...` で確認します。
5. 必要なら `make lint FILE=...` で `.tex` を明示的に確認します。
6. 自動修正できるルールだけ直したいときは `make lint-fix FILE=...` を使います。

各文書プロジェクトのルートファイルは常に `main.tex` です。生成 PDF は `build/<documents配下の相対パス>/main.pdf` に出力され、`make clean` は `build/` を丸ごと削除します。`make lint` と `make lint-fix` は `documents/` 配下の `.tex` ファイルだけを対象にし、自動では実行されません。`make lint-fix` は `textlint` が自動修正可能な違反だけを更新します。

## ディレクトリ構成

```
.
├── docker/           # Docker イメージ構築用
├── scripts/          # ビルド・lint・format 用スクリプト
├── config/           # textlint などの設定ファイル
├── documents/        # LaTeX 文書プロジェクト
└── .latexindent.yaml # latexindent 設定
```
