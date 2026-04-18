# latex-writing-env

`WSL2 + Docker Engine + VSCode` で使う、日本語 LaTeX 執筆環境です。

編集はホスト側の VSCode で行い、`build`、`lint`、`format` は Docker コンテナ内で実行します。

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
make doctor
make build FILE=documents/example-paper/thesis.tex
make watch FILE=documents/example-paper/thesis.tex
make lint FILE=documents/example-paper/thesis.tex
make format FILE=documents/example-paper/thesis.tex
make clean
make clean FILE=documents/example-paper/thesis.tex
```

## VSCode での使い方

- 推奨拡張をインストールします。
- `Tasks: Run Task` から `Create new document` を実行すると、新しい文書ディレクトリを作成できます。
- `Tasks: Run Task` から `Build current document`、`Lint current document`、`Format current document` などを実行します。
- コマンドパレットから `Tasks: Run Task` を開いて `Create new document` を選んでも同じです。
- `Ctrl+Alt+B` でも `LaTeX Workshop` からこのリポジトリの `make build` が呼ばれます。
- 保存時の自動 format / build を使いたい場合は `Run On Save` 拡張を有効にします。
- PDF は VSCode のタブ内でプレビューします。

## 新しい文書を作成する

CLI:

```bash
make new TEMPLATE=paper NAME=my-paper
```

上のコマンドを実行すると `documents/my-paper/` が作成されます。

現在選べるテンプレートは `paper` のみです。今後 `templates/` 配下にテンプレートを追加すれば、同じ導線で選べるようにできます。

生成された PDF は `build/documents/<document-name>/` 配下に出力されます。

## 新しいテンプレートを作成する

1. `templates/` 配下に新しいテンプレートディレクトリを作ります。
2. 既存の `templates/paper/` をコピーして土台にします。
3. `document.json`、ルート `.tex`、章ファイル、`refs.bib` などを用途に合わせて編集します。
4. `document.json` の `root` と `output` を正しく設定します。
5. 文書名や PDF 名を生成時に差し替えたい場合は `@@DOC_NAME@@` と `@@DOC_TITLE@@` を使います。
6. `.vscode/tasks.json` の `latexTemplate` の `options` に新しいテンプレート名を追加します。
7. `make new TEMPLATE=<template-name> NAME=test-<template-name>` で生成確認します。
8. `make build FILE=documents/test-<template-name>/thesis.tex` のようにビルド確認します。

例:

```bash
cp -r templates/paper templates/weekly-report
make new TEMPLATE=weekly-report NAME=weekly-2026-04-18
make build FILE=documents/weekly-2026-04-18/thesis.tex
```

## 既存ルールで手動追加する

1. `documents/` 配下に新しいディレクトリを作ります。
2. `document.json` に `root` と `output` を書き、必要なら `bib` に文献ファイル配列を書きます。
3. ルート `.tex` と必要な章ファイルを配置します。
4. `make build FILE=...` で確認します。

`document.json` の例:

```json
{
  "root": "thesis.tex",
  "output": "thesis.pdf",
  "bib": ["refs.bib"]
}
```
