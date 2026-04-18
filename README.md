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
- `Tasks: Run Task` から `Build current document`、`Lint current document`、`Format current document` などを実行します。
- `Ctrl+Alt+B` でも `LaTeX Workshop` からこのリポジトリの `make build` が呼ばれます。
- 保存時の自動 format / build を使いたい場合は `Run On Save` 拡張を有効にします。
- PDF は VSCode のタブ内でプレビューします。

## 新しい文書を追加する

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
